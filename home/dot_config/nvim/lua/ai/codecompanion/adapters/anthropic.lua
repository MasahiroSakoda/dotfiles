-- -*-mode:lua-*- vim:ft=lua
return function()
  return require("codecompanion.adapters").extend("anthropic", {
    schema = {
      ---@see https://docs.anthropic.com/en/docs/about-claude/models
      model = {
        default = "claude-3-5-sonnet-latest",
        choices = { "claude-3.5-sonnet-latest", "claude-3.5-haiku-latest" },
      },
    },
    env = { api_key = vim.env.ANTHROPIC_API_KEY },
  })
end
