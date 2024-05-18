local M = {}
local opt, displayed = vim.opt, true

M.toggle_line_number = function()
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

M.toggle_relative_number = function()
  opt.signcolumn = opt.signcolumn == "yes" and "no" or "yes"
  opt.relativenumber = not opt.relativenumber
end

return M
