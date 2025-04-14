-- -*-mode:lua-*- vim:ft=lua
local ok, copilot = pcall(require, "copilot")
if not ok then return end

copilot.setup({
  panel      = { enabled = false },
  suggestion = { enabled = false },
})
