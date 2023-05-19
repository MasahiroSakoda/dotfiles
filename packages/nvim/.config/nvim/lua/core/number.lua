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
  if opt.relativenumber == true then
    opt.relativenumber = false
  else
    opt.relativenumber = true
  end
end

return Number
