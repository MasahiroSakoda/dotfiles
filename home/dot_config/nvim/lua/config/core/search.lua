vim.opt.hlsearch   = true
vim.opt.incsearch  = true

vim.opt.ignorecase = true
vim.opt.smartcase  = true
vim.opt.wrapscan   = true

vim.opt.grepprg = [[rg --hidden --glob "!.git" --no-heading --smart-case --vimgrep --follow $*]]
vim.opt.grepformat:prepend { '%f:%l:%c:%m' }
