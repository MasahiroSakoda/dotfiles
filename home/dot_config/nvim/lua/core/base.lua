local opt, g = vim.opt, vim.g
if vim.loader then vim.loader.enable() end

opt.shell = 'fish'
-- Help
opt.helplang = {'ja', 'en'}

-- Backup
opt.backup = false
opt.backupskip = { '/tmp/*', '/private/tmp/*' }

opt.history  = 1000
-- opt.undofile = true

opt.updatetime  = 250
opt.timeoutlen  = 500
opt.ttimeoutlen = 200
opt.lazyredraw  = true

-- GUI
opt.mouse = 'a'
opt.visualbell = true

-- Clipboard
opt.clipboard = "unnamedplus"

-- Sroll
opt.scrolloff  = 2

-- Tab
opt.smarttab  = true
opt.expandtab = true
opt.tabstop = 2
opt.shiftwidth = 2
opt.shiftround = true

-- Indent
opt.autoindent  = true
opt.smartindent = true
opt.breakindent = true

opt.backspace   = "eol,indent,start"

-- Font
opt.guifont     = "JetBrainsMono Nerd Font Mono:h11"
opt.guifontwide = "HackGen35Nerd Console:h11"

-- Disable
-- disable menu loading
g.did_install_default_menus = 1
g.did_install_syntax_menu   = 1

g.loaded_spellfile_plugin = 1

-- Do not load native syntax completion
g.loaded_syntax_completion = 1

g.loaded_zip = 1
g.loaded_gzip = 1
g.loaded_zipPlugin = 1
g.loaded_tar = 1
g.loaded_tarPlugin = 1
g.loaded_vimball = 1
g.loaded_vimballPlugin = 1

g.loaded_matchit = 1
g.loaded_matchparen = 1

-- Disable sql omni completion.
g.loaded_sql_completion = 1
g.loaded_remote_plugins = 1 -- Disable menu loading

-- Enable open-browser.vim
g.netrw_nogx = 1
g.netrw_liststyle = 3

g.loaded_2html_plugin = 1

-- https://zenn.dev/kawarimidoll/articles/8172a4c29a6653
g.did_install_default_menus = 1
g.skip_loading_mswin        = 1
