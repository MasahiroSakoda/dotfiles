-- -*-mode:lua-*- vim:ft=lua
return function()
  return require("codecompanion.adapters").extend("openai", {
    schema = {
      ---@see https://platform.openai.com/docs/models
      model = {
        default = "gpt-4o-mini",
        choices = { "gpt-4o", "gpt-4o-mini", "o1-mini", "o3-mini" },
      },
    },
    env = { api_key = vim.env.OPENAI_API_KEY },
  })
end
