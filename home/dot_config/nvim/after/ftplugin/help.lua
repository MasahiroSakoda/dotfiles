-- -*-mode:lua-*- vim:ft=lua

vim.diagnostic.enable(false, { bufnr = 0 })

vim.opt_local.list   = false
vim.opt_local.wrap   = true
vim.opt_local.spell  = false

vim.opt_local.number         = false
vim.opt_local.relativenumber = false

vim.b.cursorword = 0
vim.cmd.wincmd("L")
