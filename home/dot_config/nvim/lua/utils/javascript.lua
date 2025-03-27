-- -*-mode:lua-*- vim:ft=lua

local M = {}

M.is_ts_project     = function()
  return vim.system({ "fd", "-tf", "-HI", "tsconfig.json" }) ~= nil and true or false
end

M.is_jest_available = function()
  local output = vim.system({ "fd", "-tf", "-HI", "--regex", "jest(.config)?.(j|t)s" }):wait().stdout
  if output == nil or output == "" then
    return false
  end
  return vim.split(output, "\n", { trimempty = true }) ~= nil and true or false
end

M.is_next_project   = function()
  local output = vim.system({ "fd", "-tf", "-HI", "--regex", "next.config.(j|t)s" }):wait().stdout
  if output == nil or output == "" then
    return false
  end
  return vim.split(output, "\n", { trimempty = true }) ~= nil and true or false
end

return M
