-- -*-mode:lua-*- vim:ft=lua
return function()
  return require("codecompanion.adapters").extend("gemini", {
    schema = {
      ---@see https://ai.google.dev/gemini-api/docs/models/gemini
      ---@usage "gemini-1.5-flash"|"gemini-1.5-flash-8b"|"gemini-1.5-pro"
      model = { default = "gemini-1.5-pro" },
    },
    env = { api_key = vim.env.GEMINI_API_KEY },
  })
end
