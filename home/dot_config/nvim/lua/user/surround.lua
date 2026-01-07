-- -*-mode:lua-*- vim:ft=lua
local ok, surround = pcall(require, "nvim-surround")
if not ok then return end

surround.setup({
  kemaps = {
    insert      = "<C-g>s",
    insert_line = "<C-g>S",
    normal      = "yss",
    normal_cur  = "yS",
    normal_line = "ySS",
    visual      = "gS",
    visual_line = "gS",
    delete      = "ds",
    change      = "cs",
    change_line = "cS",
  },
})
