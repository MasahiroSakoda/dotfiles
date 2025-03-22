-- -*-mode:lua-*- vim:ft=lua
local ok, codecompanion = pcall(require, "codecompanion")
if not ok then return end

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
    ["Correct Grammar"]       = require("ai.codecompanion.prompts.grammar"),
    ["Translate"]             = require("ai.codecompanion.prompts.translate"),
    ["Summarize"]             = require("ai.codecompanion.prompts.summarize"),
  },

  adapters = {
    groq      = require("ai.codecompanion.adapters.groq"),
    copilot   = require("ai.codecompanion.adapters.copilot"),
    openai    = require("ai.codecompanion.adapters.openai"),
    anthropic = require("ai.codecompanion.adapters.anthropic"),
    google    = require("ai.codecompanion.adapters.google"),
    qwen      = require("ai.codecompanion.adapters.qwen"),
    dolhin    = require("ai.codecompanion.adapters.dolphin"),
  },

  strategies = {
    chat   = { adapter = "qwen" },
    slash_commands = {
      ["buffer"]   = { opts = { provider = "snacks" } },
      ["fetch"]    = { opts = {} },
      ["file"]     = { opts = { provider = "snacks" } },
      ["files"]    = { opts = { provider = "snacks" } },
      ["help"]     = { opts = { provider = "snacks" } },
      ["now"]      = { opts = {} },
      ["symbols"]  = { opts = { provider = "snacks" } },
      ["terminal"] = { opts = {} },
    },
    inline = { adapter = "qwen" },
    agent  = { adapter = "ollama" },
  },

  display  = {
    chat = {
      window = {
        layout = "vertical", ---@type "float"|"vertical"|"horizontal"|"buffer"
      },
      render_headers = false,
      show_settings  = true,
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
