local ok, luasnip = pcall(require, "luasnip")
if not ok then return end

local types = require("luasnip.util.types")

-- luasnip.log.set_loglevel("debug")
luasnip.filetype_extend("c",      { "cdoc" })
luasnip.filetype_extend("rust",   { "rustdoc" })
luasnip.filetype_extend("kotlin", { "kdoc" })
luasnip.filetype_extend("php",    { "phpdoc" })
luasnip.filetype_extend("javascript", { "javascriptreact", "html" })
luasnip.filetype_extend("typescript", { "typescript", "html" })
luasnip.filetype_extend("javascriptreact", { "javascript", "html" })
luasnip.filetype_extend("typescriptreact", { "typescript", "html" })

luasnip.config.setup({
  history = true,

  -- Update more often, :h events for more info.
  update_events = "TextChanged,TextChangedI",

  -- This can be especially useful when `history` is enabled.
  region_check_events = "CursorMoved",
  delete_check_events = "TextChanged",
  enable_autosnippets = true,

  ft_func = require("luasnip.extras.filetype_functions").from_cursor,

  ext_opts = {
    [types.insertNode] = { active = { virt_text = { { "●", "GruvboxBlue" } },   hl_mode = "combine" } },
    [types.choiceNode] = { active = { virt_text = { { "●", "GruvboxOrange" } }, hl_mode = "combine" } },
  },

  -- extend filetypes
  load_ft_func = require("luasnip.extras.filetype_functions").extend_load_ft({
    markdown   = { "html", "css", "lua", "json", "yaml", "javascript", "typescript", "typescriptreact" },
    html       = { "css", "javascript", "json", "graphql" },
    javascript = { "html", "css", "graphql" },
    typescript = { "html", "css", "graphql" },
    javascriptreact = { "javascript" },
    typescriptreact = { "javascript", "typescript", "javascriptreact" },
    python = { "ipynb" },
  })
})

local current_nsid = vim.api.nvim_create_namespace("LuaSnipChoiceListSelections")
local current_win = nil

local function window_for_choiceNode(choiceNode)
  local buf, buf_text = vim.api.nvim_create_buf(false, true), {}
  local row_selection, row_offset = 0, 0
  local text
  for _, node in ipairs(choiceNode.choices) do
    text = node:get_docstring()
    -- find one that is currently showing
    if node == choiceNode.active_choice then
      -- current line is starter from buffer list which is length usually
      row_selection = #buf_text
      -- finding how many lines total within a choice selection
      row_offset = #text
    end
    vim.list_extend(buf_text, text)
  end

  vim.api.nvim_buf_set_text(buf, 0, 0, 0, 0, buf_text)
  local w, h = vim.lsp.util._make_floating_popup_size(buf_text, {})

  -- adding highlight so we can see which one is been selected.
  local extmark = vim.api.nvim_buf_set_extmark(buf, current_nsid, row_selection, 0, {
    hl_group = "incsearch",
    end_line = row_selection + row_offset,
  })

  -- shows window at a beginning of choiceNode.
  local win = vim.api.nvim_open_win(buf, false, {
    relative = "win",
    width    = w,
    height   = h,
    bufpos   = choiceNode.mark:pos_begin_end(),
    style    = "minimal",
    border   = "rounded",
  })

  -- return with 3 main important so we can use them again
  return { win_id = win, extmark = extmark, buf = buf }
end

local function choice_popup(choiceNode)
	-- build stack for nested choiceNodes.
  if current_win then
    vim.api.nvim_win_close(current_win.win_id, true)
    vim.api.nvim_buf_del_extmark(current_win.buf, current_nsid, current_win.extmark)
  end
  local create_win = window_for_choiceNode(choiceNode)
  current_win = {
    win_id  = create_win.win_id,
    prev    = current_win,
    node    = choiceNode,
    extmark = create_win.extmark,
    buf     = create_win.buf
  }
end

local function update_choice_popup(choiceNode)
  ---@cast current_win -nil
  vim.api.nvim_win_close(current_win.win_id, true)
  vim.api.nvim_buf_del_extmark(current_win.buf, current_nsid, current_win.extmark)
  local create_win = window_for_choiceNode(choiceNode)
  current_win.win_id  = create_win.win_id
  current_win.extmark = create_win.extmark
  current_win.buf     = create_win.buf
end

local function choice_popup_close()
  ---@cast current_win -nil
	vim.api.nvim_win_close(current_win.win_id, true)
  vim.api.nvim_buf_del_extmark(current_win.buf, current_nsid, current_win.extmark)
        -- now we are checking if we still have previous choice we were in after exit nested choice
	current_win = current_win.prev
	if current_win then
		-- reopen window further down in the stack.
    local create_win    = window_for_choiceNode(current_win.node)
    current_win.win_id  = create_win.win_id
    current_win.extmark = create_win.extmark
    current_win.buf     = create_win.buf
  end
end

local choice_popup_g = vim.api.nvim_create_augroup("LuaSnipChoicePopup", { clear = true })
vim.api.nvim_create_autocmd("User", {
  pattern  = "LuasnipChoiceNodeEnter",
  group    = choice_popup_g,
  callback = function(_) choice_popup(luasnip.session.event_node) end,
})

vim.api.nvim_create_autocmd("User", {
  pattern  = "LuasnipChoiceNodeLeave",
  group    = choice_popup_g,
  callback = function(_) choice_popup_close() end,
})

vim.api.nvim_create_autocmd("User", {
  pattern  = "LuasnipChangeChoice",
  group    = choice_popup_g,
  callback = function(_) update_choice_popup(luasnip.session.event_node) end,
})

vim.api.nvim_create_user_command("LuaSnipReload", function()
  require("utils.snippet").reload()
end, { desc = "Reload luasnip snippets", nargs = "*", bang = true })

vim.api.nvim_create_user_command("LuaSnipEdit", function()
  -- require("luasnip.loaders").edit_snippet_files({})
  Snacks.picker.smart({ cwd = os.getenv("XDG_DATA_HOME") .. "/chezmoi/home/dot_config/nvim/lua/snippets" })
end, { desc = "", nargs = "*", bang = true })

vim.api.nvim_create_user_command("LuaSnipBrowse", function()
  local items = require("utils.snippet").snippets()
  Snacks.picker.pick({
    items  = items,
    format = function(item, _)
      local snip, a = {}, Snacks.picker.util.align
      local icon, icon_hl = Snacks.util.icon(item.ft, "snippet")
      snip[#snip + 1] = { a(string.format("%-03d", item.idx), 3) }
      snip[#snip + 1] = { a(icon, 3), icon_hl }
      snip[#snip + 1] = { a(item.ft, 10) }
      snip[#snip + 1] = { a(item.trig, 15) }
      snip[#snip + 1] = { a(item.name, 20) }
      return snip
    end,
    preview = "none",
    confirm = function(picker, _) picker:close() end,
  })
end, { desc = "", nargs = "*", bang = true })
