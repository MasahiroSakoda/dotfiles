-- -*-mode:lua-*- vim:ft=lua
return function()
  return require("codecompanion.adapters").extend("gemini", {
    schema = {
      ---@see https://ai.google.dev/gemini-api/docs/models/gemini
      model = {
        default = "gemini-2.5-flash",
        choices = { "gemini-2.5-flash", "gemini-2.5-pro", "gemini-2.0-flash", "gemini-2.0-flash-lite" },
      },
    },
    env = { api_key = vim.env.GEMINI_API_KEY },
  })
end
