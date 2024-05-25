-- -*-mode:lua-*- vim:ft=lua

local ok, trouble = pcall(require, "trouble")
local M = {}
if not ok then return end

M.prev = function()
  if trouble.is_open() then
    trouble.previous({ skip_groups = true, jump = true })
  else
    local prev_ok, _ = pcall(vim.cmd.cprev)
    if not prev_ok then return end
  end
end

M.next = function()
  if trouble.is_open() then
    trouble.previous({ skip_groups = true, jump = true })
  else
    local next_ok, _ = pcall(vim.cmd.cnext)
    if not next_ok then return end
  end
end

return M
