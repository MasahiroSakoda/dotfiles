local Number = {}

local opt = vim.opt
local displayed = true

Number.toggleLineNumber = function()
  if displayed then
    opt.signcolumn = "no"
    opt.number = false
    opt.relativenumber = false
    displayed = false
  else
    opt.signcolumn = "yes"
    opt.number = true
    opt.relativenumber = true
    displayed = true
  end
end

Number.toggleRelativeNumber = function()
  vim.o.signcolumn = vim.o.signcolumn == "yes" and "no" or "yes"
  vim.o.relativenumber = not vim.o.relativenumber
end

return Number
