-- -*-mode:lua-*- vim:ft=lua

local M = {}

function M.format_tag(id, db)
  local icons = {
    news     = "📰 ",
    tech     = "💻 ",
    dev      = "🛠️ ",
    security = "🛡️ ",
    ai       = "🤖 ",
    status   = "󱖫 ",
    movies   = "🎬 ",
    games    = "🎮 ",
    music    = "🎵 ",
    podcast  = "🎧 ",
    books    = "📚 ",
    unread   = "🟩 ",
    read     = "✅ ",
    junk     = "🗑️ ",
    star     = "⭐ ",

    release    = " ",
    github     = " ",
    google     = " ",
    nvim       = " ",
    cloud      = " ",
    gcloud     = " ",
    cloudflare = " ",
    azure      = " ",
    vercel     = " ",
    supabase   = " ",
    discord    = " ",
    slack      = " ",
    openai     = "֎ ",
    reddit     = " ",
    dotfiles   = " ",
  }
  local get_icon = function(name)
    if icons[name] then return icons[name] end
    local icon = require("utils.icon").file_icon(name, false)
    return not icon and name or icon .. " "
  end

  local tags = vim.tbl_map(get_icon, db:get_tags(id))
  table.sort(tags)
  return "[" .. table.concat(tags, ", ") .. "]"
end

function M.estimate_time(id, db)
  local cpm, content = 1000, db:get(id):gsub("%s+", " ")
  local chars = vim.fn.strchars(content)
  return string.format("(%s min)", math.ceil(chars / cpm))
end

function M.play_podcast()
  local link = require("feed").get_entry().link
  return link:find("mp3") and vim.ui.open(link) or vim.notify("not a podcast episode")
end

function M.show_in_w3m()
  if not vim.fn.executable("w3m") then
    vim.notify("w3m not installed")
    return
  end
  local link = require("feed").get_entry().link

  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    col    = math.floor(vim.o.columns * 0.1),
    row    = math.floor(vim.o.lines * 0.1),
    width  = math.floor(vim.o.columns * 0.8),
    height = math.floor(vim.o.lines * 0.8),
    border = "rounded",
    style  = "minimal",
    title  = "Feed glow",
    zindex = 10,
  })
  vim.keymap.set({ "n", "t" }, "q", "<cmd>q<cr>", { silent = true, buffer = buf })
  vim.fn.jobstart({ "w3m", link }, { term = true })
  vim.cmd("startinsert")
end

function M.show_in_glow()
  local feed = require("feed")
  local id = feed.get_entry().id
  assert(id)
  local fp = feed.db:get_path(id)
  local cmd = string.format("pandoc -f html -t gfm %s | glow -t", fp)
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    col = math.floor(vim.o.columns * 0.1),
    row = math.floor(vim.o.lines * 0.1),
    width = math.floor(vim.o.columns * 0.8),
    height = math.floor(vim.o.lines * 0.8),
    border = "rounded",
    style = "minimal",
    title = "Feed glow",
    zindex = 10,
  })
  vim.keymap.set({ "n", "t" }, "q", "<cmd>q<cr>", { silent = true, buffer = buf })
  vim.fn.jobstart(cmd, { term = true })
end

return M
