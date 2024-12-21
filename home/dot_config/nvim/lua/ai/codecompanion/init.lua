-- -*-mode:lua-*- vim:ft=lua
local ok, codecompanion = pcall(require, "codecompanion")
if not ok then return end

local adapters = require("codecompanion.adapters")

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
    ---@see https://github.com/copilot
    copilot = function()
      return adapters.extend("copilot", {
        schema = {
          ---@usage "gpt-4o"|"claude-3.5-sonnet"
          model = { default = "claude-3.5-sonnet" },
        },
      })
    end,

    ---@see https://platform.openai.com/docs/models
    openai = function()
      return adapters.extend("openai", {
        schema = {
          ---@usage "gpt-3.5-turbo"|"gpt-4o"|"gpt-4o-mini"
          model = { default = "gpt-4o-mini" },
        },
        env = { api_key = vim.env.OPENAI_API_KEY },
      })
    end,

    ---@see https://docs.anthropic.com/en/docs/about-claude/models
    anthropic = function()
      return adapters.extend("anthropic", {
        schema = {
          ---@usage "claude-3-5-sonnet-latest"|"claude-3.5-haiku-latest"
          model = { default = "claude-3-5-sonnet-latest" },
        },
        env = { api_key = vim.env.ANTHROPIC_API_KEY },
      })
    end,

    ---@see https://ai.google.dev/gemini-api/docs/models/gemini
    gemini = function()
      return adapters.extend("gemini", {
        schema = {
          ---@usage "gemini-1.5-flash"|"gemini-1.5-flash-8b"|"gemini-1.5-pro"
          model = { default = "gemini-1.5-pro" },
        },
        env = { api_key = vim.env.GEMINI_API_KEY },
      })
    end,

    ollama = function()
      return require("codecompanion.adapters").extend("ollama", {
        name   = "mistral",
        schema = { model = { default = vim.g.local_llm } },
      })
    end,
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
