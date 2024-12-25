-- -*-mode:lua-*- vim:ft=lua
return function()
  return require("codecompanion.adapters").extend("copilot", {
    schema = {
      ---@see https://github.com/copilot
      ---@usage "gpt-4o"|"claude-3.5-sonnet"
      model = {
        default = "claude-3.5-sonnet",
        choices = { "gpt-4o", "claude-3.5-sonnet" },
      },
    },
  })
end