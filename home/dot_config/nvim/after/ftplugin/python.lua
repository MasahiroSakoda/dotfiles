local opt = vim.opt
opt.tabstop     = 4
opt.shiftwidth  = 4
opt.softtabstop = 4

require("luasnip").filetype_extend("python", { "django" })
