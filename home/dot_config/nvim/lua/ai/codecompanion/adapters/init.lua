-- -*-mode:lua-*- vim:ft=lua

return {
  http = {
    groq      = require("ai.codecompanion.adapters.http.groq"),
    copilot   = require("ai.codecompanion.adapters.http.copilot"),
    openai    = require("ai.codecompanion.adapters.http.openai"),
    anthropic = require("ai.codecompanion.adapters.http.anthropic"),
    gemini    = require("ai.codecompanion.adapters.http.gemini"),
    qwen      = require("ai.codecompanion.adapters.http.qwen"),
    ollama    = require("ai.codecompanion.adapters.http.ollama"),
  },
}
