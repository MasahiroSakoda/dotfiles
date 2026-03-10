-- -*-mode:lua-*- vim:ft=lua
local ok, surround = pcall(require, "nvim-surround")
if not ok then return end

surround.setup({
  highlight = { duration = 200 },
  keymaps = {
    normal      = "gs",
    normal_cur  = false,
    normal_line = false,
    insert      = "<C-y>s",
    insert_line = "<C-y>s",
    visual      = "gs",
    visual_line = false,
    change      = "gsc",
    change_line = false,
    delete      = "gsd"
  },
})

-- Prevent overlap warning
vim.keymap.del("n", "gs")
