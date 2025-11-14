-- -*-mode:lua-*- vim:ft=lua

return function()
  return require("codecompanion.adapters").extend("gemini_cli", {
    defaults = {
      auth_method = "oauth-personal", ---@type "oauth-personal"|"gemini-api-key"|"vertex-ai"
    },
    env = {},
  })
end
