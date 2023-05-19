local Quickfix = {}
local fn, g = vim.fn, vim.g

local isQuickfixOpen = function()
  for i = 1, fn.winnr("$") do
    if fn.getbufvar(fn.winbufnr(i), "&buftype") == "quickfix" then
      return true
    end
  end
  return false
end

Quickfix.toggleQuickfix = function()
  if isQuickfixOpen() then
    vim.cmd("cclose")
    if g.quickfix_return_to_window then
      vim.cmd(g.quickfix_return_to_window .. "wincmd w")
    end
  else
    g.quickfix_return_to_window = fn.winnr()

    vim.cmd [[copen]]
  end
end

Quickfix.navigateQuickfix = function(direction)
  return function()
    if not isQuickfixOpen() then
      return
    end
    vim.cmd('silent! execute "normal! :c' .. direction .. '\\<CR>"')
  end
end

return Quickfix
