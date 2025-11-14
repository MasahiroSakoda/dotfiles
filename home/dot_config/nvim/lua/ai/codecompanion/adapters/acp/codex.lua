-- -*-mode:lua-*- vim:ft=lua

return function()
  return require("codecompanion.adapters").extend("codex", {
    defaults = {
      auth_method = "openai-api-key", ---@type "openai-api-key"|"codex-api-key"|"chatgpt"
    },
    env = { OPENAI_API_KEY = os.getenv("OPENAI_API_KEY") },
  })
end
