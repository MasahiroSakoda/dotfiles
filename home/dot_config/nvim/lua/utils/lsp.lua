-- -*-mode:lua-*- vim:ft=lua
local M = {}

M.toggle_diagnostics = function()
  local is_enabled = vim.diagnostic.is_enabled({ bufnr = 0 })
  vim.diagnostic.enable(not is_enabled, { bufnr = 0 })
  print("Diagnostics: " .. tostring(not is_enabled))
end

---@param bufnr integer
M.toggle_inlay_hints = function(bufnr)
  local is_enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr })
  vim.lsp.inlay_hint.enable(not is_enabled)
  print("Inlay Hints: " .. tostring(not is_enabled))
end

return M
