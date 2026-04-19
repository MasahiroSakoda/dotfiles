-- -*-mode:lua-*- vim:ft=lua
local ok, surround = pcall(require, "nvim-surround")
if not ok then return end

surround.setup({
  highlight = { duration = 200 },
  keymaps = {
    normal      = "gs",
    normal_cur  = "gss",
    normal_line = "gS",
    insert      = "<C-g>s",
    insert_line = "<C-g>S",
    visual      = "gS",
    visual_line = "gSS",
    change      = "gsc",
    change_line = "gSc",
    delete      = "gsd"
  },
})

-- pcall(vim.keymap.del, { "n" }, "gs")
-- pcall(vim.keymap.del, { "n", "x" }, "gS")
