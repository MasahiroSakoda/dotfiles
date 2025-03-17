-- -*-mode:lua-*- vim:ft=lua

-- Color Schemes
vim.cmd.colorscheme(vim.g.colorscheme)

local palette = require("onedark.palette")[vim.g.themestyle]
vim.api.nvim_set_hl(0, "SnacksPickerDir",        { fg = palette.cyan })
vim.api.nvim_set_hl(0, "SnacksPickerPathHidden", { fg = palette.bg3 })
