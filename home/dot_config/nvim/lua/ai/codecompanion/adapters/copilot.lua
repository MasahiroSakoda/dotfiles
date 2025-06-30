-- -*-mode:lua-*- vim:ft=lua
return function()
  return require("codecompanion.adapters").extend("copilot", {
    schema = {
      ---@see https://github.com/copilot
      model = {
        default = "claude-3.7-sonnet",
        choices = { "claude-3.7-sonnet", "claude-sonent-4", "o3-mini-2025-01-31" },
      },
      reasoning_effort = {
        default = "medium", ---@type "high"|"medium"|"low"
      },
    },
  })
end
