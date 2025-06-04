-- -*-mode:lua-*- vim:ft=lua
return function()
  return require("codecompanion.adapters").extend("anthropic", {
    schema = {
      ---@see https://docs.anthropic.com/en/docs/about-claude/models
      model = {
        default = "claude-sonnet-4-0",
        choices = { "claude-sonnet-4-0", "claude-opus-4-0" },
      },
    },
    env = { api_key = vim.env.ANTHROPIC_API_KEY },
  })
end
