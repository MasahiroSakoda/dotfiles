local opt = vim.opt
opt.tabstop     = 2
opt.shiftwidth  = 2
opt.softtabstop = 2

require("luasnip").filetype_extend("ruby", { "rails" })
