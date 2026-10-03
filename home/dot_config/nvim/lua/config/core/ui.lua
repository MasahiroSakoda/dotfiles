vim.opt.title = false
vim.opt.shell = "fish"

vim.opt.number = true
vim.opt.relativenumber = false
vim.opt.numberwidth = 2

vim.o.winborder  = "rounded"
vim.opt.winblend = 25
vim.opt.pumblend = 25
vim.g.floaterm_winblend = 35

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.cursorline  = true
vim.opt.signcolumn  = "auto:1"

local palette = require("onedark.palette")[vim.g.themestyle]
vim.api.nvim_set_hl(0, "CursorLineNr", { ctermbg = 0, fg = palette.yellow })
vim.api.nvim_set_hl(0, "ColorColumn",  { ctermbg = 0, bg = palette.bg0 })
vim.api.nvim_set_hl(0, "SignColumn",   { ctermbg = 0, bg = palette.bg0 })

vim.g.highlighturl_enabled = true

vim.opt.termguicolors = true
vim.opt.background    = "dark"

vim.opt.cmdheight  = 0
vim.opt.laststatus = 3
vim.opt.showcmd    = true
vim.opt.showmode   = true

vim.opt.list = true
vim.opt.listchars = { space = "･", eol = "↲", tab = "→ ", trail = "•", nbsp = "_", extends = "⟩", precedes = "⟨" }

vim.api.nvim_set_hl(0, "SnacksPickerDir",               { fg = palette.cyan })
vim.api.nvim_set_hl(0, "SnacksPickerFile",              { fg = palette.bg_yellow })
vim.api.nvim_set_hl(0, "SnacksPickerPathHidden",        { fg = palette.bg3 })
vim.api.nvim_set_hl(0, "SnacksPickerMatch",             { fg = palette.red })
vim.api.nvim_set_hl(0, "SnacksPickerPreviewCursorLine", { bg = palette.bg3 })
