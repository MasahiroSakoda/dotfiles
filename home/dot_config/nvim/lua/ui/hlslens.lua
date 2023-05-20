local hlslens_ok, hlslens     = pcall(require, "hlslens")
local searchbar_ok, searchbar = pcall(require, "scrollbar.handlers.search")
if not (hlslens_ok or searchbar_ok) then return end

hlslens.setup({
  calm_down = true,
  nearest_only = true,
  -- nearest_float_when = 'always',

  build_position_cb = function(plist, _, _, _)
    searchbar.handler.show(plist.start_pos)
  end,

  -- Activate Scrollbar search
  -- searchbar.setup({
  --   -- hlslens config overrides
  --   override_lens = function() end,
  -- }),
})

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }
keymap("n", "n", [[<CMD>execute("normal! " . v:count1 . "n")<CR><CMD>lua require("hlslens").start()<CR>]], opts)
keymap("n", "N", [[<CMD>execute("normal! " . v:count1 . "N")<CR><CMD>lua require("hlslens").start()<CR>]], opts)

keymap("n", "*",  [[*<CMD>lua require("hlslens").start()<CR>]], opts)
keymap("n", "#",  [[#<CMD>lua require("hlslens").start()<CR>]], opts)
keymap("n", "g*", [[g*<CMD>lua require("hlslens").start()<CR>]], opts)
keymap("n", "g#", [[g#<CMD>lua require("hlslens").start()<CR>]], opts)

vim.cmd [[
  augroup scrollbar_search_hide
    autocmd!
    autocmd CmdlineLeave : lua require('scrollbar.handlers.search').handler.hide()
  augroup END
]]
