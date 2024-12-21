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
    copilot = function()
      return require("codecompanion.adapters").extend("copilot", {
        schema = { ---@see https://github.com/copilot
          model = {
            default = "claude-3.5-sonnet", ---@type "gpt-4o"|"claude-3.5-sonnet"
          },
        },
      })
    end,

    openai = function()
      return require("codecompanion.adapters").extend("openai", {
        schema = { ---@see https://platform.openai.com/docs/models
          model = {
            default = "gpt-4o-mini", ---@type "gpt-3.5-turbo"|"gpt-4o"|"gpt-4o-mini"
          },
        },
        env = { api_key = vim.env.OPENAI_API_KEY },
      })
    end,

    anthropic = function()
      return require("codecompanion.adapters").extend("anthropic", {
        schema = { ---@see https://docs.anthropic.com/en/docs/about-claude/models
          model = {
            default = "claude-3-5-sonnet-latest", ---@type "claude-3-5-sonnet-latest"|"claude-3.5-haiku-latest"
          },
        },
        env = { api_key = vim.env.ANTHROPIC_API_KEY },
      })
    end,

    gemini = function()
      return require("codecompanion.adapters").extend("gemini", {
        schema = { ---@see https://ai.google.dev/gemini-api/docs/models/gemini
          model = {
            default = "gemini-1.5-pro", ---@type "gemini-1.5-flash"|"gemini-1.5-flash-8b"|"gemini-1.5-pro"
          },
        },
        env = { api_key = vim.env.GEMINI_API_KEY },
      })
    end,

    ollama = function()
      return require("codecompanion.adapters").extend("ollama", {
        name   = "mistral",
        schema = {
          model = { default = vim.g.local_llm },
        },
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
      render_headers = false,
      show_settings  = true,
    },
    diff = {
      layout   = "vertical", ---@type "horizontal"|"vertical"
      provider = "default",  ---@type "default"|"mini_diff"
    },
  },
})
