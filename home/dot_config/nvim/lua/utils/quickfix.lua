local M = {}
local fn, g, cmd = vim.fn, vim.g, vim.cmd

local is_quickfix_open = function()
  for i = 1, fn.winnr("$") do
    if fn.getbufvar(fn.winbufnr(i), "&buftype") == "quickfix" then return true end
  end
  return false
end

M.toggle_quickfix = function()
  if is_quickfix_open() then
    cmd("cclose")
    if g.quickfix_return_to_window then cmd(g.quickfix_return_to_window .. "wincmd w") end
  else
    g.quickfix_return_to_window = fn.winnr()

    cmd [[copen]]
  end
end

return M
