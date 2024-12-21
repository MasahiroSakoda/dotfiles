-- -*-mode:lua-*- vim:ft=lua
local ok, codecompanion = pcall(require, "codecompanion")
if not ok then return end

require("utils.ai")

codecompanion.setup({
  opts = {
    log_level = "TRACE",   ---@type "DEBUG"|"TRACE"
    language  = "English", ---@type "English"|"Japanese"
  },

  prompt_library = {
    ["Documentation"]         = require("ai.codecompanion.prompts.documentation"),
    ["Refactor Code in chat"] = require("ai.codecompanion.prompts.refactor_chat"),
    ["Refactor Code inline"]  = require("ai.codecompanion.prompts.refactor_inline"),
    ["Review"]                = require("ai.codecompanion.prompts.review"),
    ["PullRequest"]           = require("ai.codecompanion.prompts.pull_request"),
  },

  adapters = {
    groq      = require("ai.codecompanion.adapters.groq"),
    copilot   = require("ai.codecompanion.adapters.copilot"),
    openai    = require("ai.codecompanion.adapters.openai"),
    anthropic = require("ai.codecompanion.adapters.anthropic"),
    google    = require("ai.codecompanion.adapters.google"),
    ollama    = require("ai.codecompanion.adapters.ollama"),
  },

  strategies = {
    chat   = { adapter = "ollama" },
    inline = { adapter = "ollama" },
    agent  = { adapter = "ollama" },
  },

  display  = {
    chat = {
      window = {
        layout = "vertical", ---@type "float"|"vertical"|"horizontal"|"buffer"
      },
      render_headers = false,
      show_settings  = false,
    },
    diff = {
      layout   = "vertical", ---@type "horizontal"|"vertical"
      provider = "default",  ---@type "default"|"mini_diff"
    },
    inline = {
      layout = "vertical",   ---@type "vertical"|"horizontal"|"buffer"
    },
  },
})
