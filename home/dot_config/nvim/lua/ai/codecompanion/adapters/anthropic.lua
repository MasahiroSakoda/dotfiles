-- -*-mode:lua-*- vim:ft=lua
return function()
  return require("codecompanion.adapters").extend("anthropic", {
    schema = {
      ---@usage "claude-3-5-sonnet-latest"|"claude-3.5-haiku-latest"
      model = { default = "claude-3-5-sonnet-latest" },
    },
    env = { api_key = vim.env.ANTHROPIC_API_KEY },
  })
end
