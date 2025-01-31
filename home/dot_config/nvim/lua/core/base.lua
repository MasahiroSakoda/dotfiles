-- -*-mode:lua-*- vim:ft=lua
if vim.loader then vim.loader.enable() end

-- vim.opt.shell = "fish"

-- locale
vim.cmd([[
" language ja_JP.UTF-8
language en_US.UTF-8
]])

-- Help
vim.opt.helplang = {'ja', 'en'}

-- Backup
vim.opt.backup = false
vim.opt.backupskip = { '/tmp/*', '/private/tmp/*' }

vim.opt.history  = 1000
-- opt.undofile = true

vim.opt.updatetime  = 250
vim.opt.timeoutlen  = 500
vim.opt.ttimeoutlen = 200
vim.opt.lazyredraw  = false -- disable due to noice.nvim

-- GUI
vim.opt.mouse = "a"
vim.opt.visualbell = true

-- Clipboard
vim.opt.clipboard = "unnamedplus"

-- Sroll
vim.opt.scrolloff  = 2

-- Tab
vim.opt.smarttab  = true
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.shiftround = true

-- Indent
vim.opt.autoindent  = true
vim.opt.smartindent = true
vim.opt.breakindent = true

vim.opt.backspace   = "eol,indent,start"

-- Disable
-- disable menu loading
vim.g.did_install_default_menus = 1
vim.g.did_install_syntax_menu   = 1

vim.g.loaded_spellfile_plugin = 1

-- Do not load native syntax completion
vim.g.loaded_syntax_completion = 1

vim.g.loaded_zip           = 1
vim.g.loaded_gzip          = 1
vim.g.loaded_zipPlugin     = 1
vim.g.loaded_tar           = 1
vim.g.loaded_tarPlugin     = 1
vim.g.loaded_vimball       = 1
vim.g.loaded_vimballPlugin = 1

vim.g.loaded_matchit    = 1
vim.g.loaded_matchparen = 1

-- Disable sql omni completion.
vim.g.loaded_sql_completion = 1
vim.g.loaded_remote_plugins = 1 -- Disable menu loading

-- Enable open-browser.vim
vim.g.netrw_nogx      = 1
vim.g.netrw_liststyle = 3

vim.g.loaded_2html_plugin = 1

-- https://zenn.dev/kawarimidoll/articles/8172a4c29a6653
vim.g.did_install_default_menus = 1
vim.g.skip_loading_mswin        = 1
