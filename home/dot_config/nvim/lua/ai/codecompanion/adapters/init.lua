-- -*-mode:lua-*- vim:ft=lua

return {
  groq      = require("ai.codecompanion.adapters.groq"),
  copilot   = require("ai.codecompanion.adapters.copilot"),
  openai    = require("ai.codecompanion.adapters.openai"),
  anthropic = require("ai.codecompanion.adapters.anthropic"),
  google    = require("ai.codecompanion.adapters.google"),
  qwen      = require("ai.codecompanion.adapters.qwen"),
  ollama    = require("ai.codecompanion.adapters.ollama"),
}
