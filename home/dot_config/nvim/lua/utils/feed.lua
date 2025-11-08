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

return M
