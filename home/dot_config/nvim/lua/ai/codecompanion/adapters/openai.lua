-- -*-mode:lua-*- vim:ft=lua
return function()
  return require("adapters").extend("openai", {
    schema = {
      ---@see https://platform.openai.com/docs/models
      model = {
        default = "gpt-4o-mini",
        choices = { "gpt-3.5-turbo", "gpt-4o", "gpt-4o-mini" },
      },
    },
    env = { api_key = vim.env.OPENAI_API_KEY },
  })
end
