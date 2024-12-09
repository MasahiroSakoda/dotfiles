local ok, hlslens = pcall(require, "hlslens")
if not ok then return end

hlslens.setup({
  calm_down = true,
  nearest_only = true,
  -- nearest_float_when = 'always',

  -- build_position_cb = function(plist, _, _, _)
  --   searchbar.handler.show(plist.start_pos)
  -- end,
})

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }
keymap("n", "n", [[<CMD>execute("normal! " . v:count1 . "n")<CR><CMD>lua require("hlslens").start()<CR>]], opts)
keymap("n", "N", [[<CMD>execute("normal! " . v:count1 . "N")<CR><CMD>lua require("hlslens").start()<CR>]], opts)

keymap("n", "*",  [[*<CMD>lua require("hlslens").start()<CR>]], opts)
keymap("n", "#",  [[#<CMD>lua require("hlslens").start()<CR>]], opts)
keymap("n", "g*", [[g*<CMD>lua require("hlslens").start()<CR>]], opts)
keymap("n", "g#", [[g#<CMD>lua require("hlslens").start()<CR>]], opts)
