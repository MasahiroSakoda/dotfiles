-- -*-mode:lua-*- vim:ft=lua
local ok, copilot = pcall(require, "copilot")
if not ok then return end

copilot.setup({
  panel      = { enabled = false },
  suggestion = { enabled = false },
})

vim.api.nvim_create_user_command("ToogleCopilotSuggest", function()
  local suggestion = require("copilot.suggestion")
  if suggestion.is_enabled() then
    vim.notify("Copilot auto suggestion disabled.", vim.log.levels.INFO)
  else
    vim.notify("Copilot auto suggestion enabled.", vim.log.levels.INFO)
  end
  suggestion.toggle_auto_trigger()
end, { desc = "Toggle Copilot Suggestion", nargs = "*", bang = true })
