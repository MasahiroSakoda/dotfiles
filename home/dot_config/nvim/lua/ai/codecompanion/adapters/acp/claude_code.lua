-- -*-mode:lua-*- vim:ft=lua

return function()
  return require("codecompanion.adapters").extend("claude_code", {
    env = { CLAUDE_CODE_OAUTH_TOKEN = os.getenv("CLAUDE_CODE_OAUTH_TOKEN") },
  })
end
