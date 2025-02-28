-- -*-mode:lua-*- vim:ft=lua
return function()
  return require("codecompanion.adapters").extend("gemini", {
    schema = {
      ---@see https://ai.google.dev/gemini-api/docs/models/gemini
      model = {
        default = "gemini-2.0-flash",
        choices = { "gemini-2.0-flash", "gemini-1.5-flash-8b", "gemini-1.5-pro" },
      },
    },
    env = { api_key = vim.env.GEMINI_API_KEY },
  })
end
