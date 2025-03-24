local opt, g, env = vim.opt, vim.g, vim.env

opt.title = false
opt.shell = "fish"

-- Line Numbers
opt.number = true
opt.relativenumber = false
opt.numberwidth = 2
-- display line number for help
vim.cmd[[autocmd! FileType help setlocal number]]

opt.cursorline = true

-- Transparent window
opt.winblend = 25
opt.pumblend = 25
g.floaterm_winblend = 35

opt.splitbelow = true
opt.splitright = true

env.NVIM_TUI_ENABLE_TRUE_COLOR = 1
opt.termguicolors = true
opt.background    = "dark"

-- Command
opt.cmdheight  = 0
opt.showcmd    = true
opt.showmode   = true
-- opt.ambiwidth  = 'double'
opt.laststatus = 3

opt.list = true
opt.listchars = { space = "･", eol = "↴", tab = "»-", trail = "-", nbsp = "%", extends = "⟩", precedes = "⟨" }
