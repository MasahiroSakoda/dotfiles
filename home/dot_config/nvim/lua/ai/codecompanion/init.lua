-- -*-mode:lua-*- vim:ft=lua
local ok, codecompanion = pcall(require, "codecompanion")
if not ok then return end

vim.g.local_llm = "dolphin3:latest"

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
    ollama    = require("ai.codecompanion.adapters.ollama"),
  },

  strategies = {
    chat   = { adapter = "ollama" },
    slash_commands = {
      ["buffer"]   = { opts = { provider = "fzf_lua" } },
      ["fetch"]    = { opts = {} },
      ["file"]     = { opts = { provider = "fzf_lua" } },
      ["files"]    = { opts = { provider = "fzf_lua" } },
      ["help"]     = { opts = { provider = "fzf_lua" } },
      ["now"]      = { opts = {} },
      ["symbols"]  = { opts = { provider = "fzf_lua" } },
      ["terminal"] = { opts = {} },
    },
    inline = { adapter = "ollama" },
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
