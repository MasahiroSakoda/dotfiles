-- -*-mode:lua-*- vim:ft=lua
return function()
  return require("codecompanion.adapters").extend("gemini", {
    schema = {
      ---@see https://ai.google.dev/gemini-api/docs/models/gemini
      model = {
        default = "gemini-2.0-flash",
        choices = {
          ["gemini-2.5-flash"]      = { opts = { can_reason = true, has_vision = true } },
          ["gemini-2.5-pro"]        = { opts = { can_reason = true, has_vision = true } },
          ["gemini-2.0-flash"]      = { opts = { has_vision = true } },
          ["gemini-2.0-flash-lite"] = { opts = { has_vision = true } },
        },
      },
    },
    env = { api_key = vim.env.GEMINI_API_KEY },
  })
end
