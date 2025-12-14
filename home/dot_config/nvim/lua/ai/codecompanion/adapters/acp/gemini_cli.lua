-- -*-mode:lua-*- vim:ft=lua

return function()
  return require("codecompanion.adapters").extend("gemini_cli", {
    defaults = {
      ---@type "oauth-personal"|"gemini-api-key"|"vertex-ai"
      auth_method = "oauth-personal",
    },
    env = {},
    ---@see https://geminicli.com/docs/get-started/configuration/#command-line-arguments
    commands = {
      default = { "gemini", "-m", "gemini-2.5-flash" },
      flash   = { "gemini", "-m", "gemini-2.5-flash" },
      pro     = { "gemini", "-m", "gemini-2.5-pro" }
    },
  })
end
