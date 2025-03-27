-- -*-mode:lua-*- vim:ft=lua
-- Color Schemes
vim.cmd.colorscheme(vim.g.colorscheme)

vim.opt.title = false
vim.opt.shell = "fish"

-- Line Numbers
vim.opt.number = true
vim.opt.relativenumber = false
vim.opt.numberwidth = 2
-- display line number for help
vim.cmd[[autocmd! FileType help setlocal number]]

-- opt.cursorline   = true
-- opt.cursorcolumn = true

-- Cursor
local palette = require("onedark.palette")[vim.g.themestyle]
vim.opt.colorcolumn = { "120" }
vim.opt.signcolumn  = "auto:1"
vim.api.nvim_set_hl(0, "ColorColumn", { ctermbg=0, bg=palette.bg0 })
vim.api.nvim_set_hl(0, "SignColumn",  { ctermbg=0, bg=palette.bg0 })

-- Transparent window
vim.opt.winblend = 25
vim.opt.pumblend = 25
vim.g.floaterm_winblend = 35

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.env.NVIM_TUI_ENABLE_TRUE_COLOR = 1
vim.opt.termguicolors = true
vim.opt.background    = "dark"

-- Command
vim.opt.cmdheight  = 0
vim.opt.showcmd    = true
vim.opt.showmode   = true
-- opt.ambiwidth  = 'double'
vim.opt.laststatus = 3

vim.opt.list = true
vim.opt.listchars = { space = "･", eol = "↴", tab = "»-", trail = "-", nbsp = "%", extends = "⟩", precedes = "⟨" }

-- Highlights
vim.api.nvim_set_hl(0, "SnacksPickerDir",               { fg = palette.cyan })
vim.api.nvim_set_hl(0, "SnacksPickerFile",              { fg = palette.bg_yellow })
vim.api.nvim_set_hl(0, "SnacksPickerPathHidden",        { fg = palette.bg3 })
vim.api.nvim_set_hl(0, "SnacksPickerSearch",            { fg = palette.red })
vim.api.nvim_set_hl(0, "SnacksPickerPreviewCursorLine", { bg = palette.bg3 })
