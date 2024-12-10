-- -*-mode:lua-*- vim:ft=lua
local ok, codecompanion = pcall(require, "codecompanion")
if not ok then return end

require("utils.ai")

codecompanion.setup({
  opts = {
    log_level = "TRACE",   ---@type "DEBUG"|"TRACE"
    language  = "English", ---@type "English"|"Japanese"

    -- system_prompt = function(opts)
    --   if opts.adapter.schema.model.default == model then
    --     return "My custom system prompt"
    --   end
    --   return "My default system prompt"
    -- end,
  },

  adapters = {
    openai = function()
      return require("codecompanion.adapters").extend("openai", {
        schema = {
          model = {
            ---@see https://platform.openai.com/docs/models
            ---@type "gpt-3.5-turbo"|"gpt-4o"|"gpt-4o-mini"
            default = "gpt-4o-mini",
          },
        },
        env = {
          api_key = vim.env.OPENAI_API_KEY,
        },
      })
    end,

    anthropic = function()
      return require("codecompanion.adapters").extend("anthropic", {
        schema = {
          model = {
            ---@see https://docs.anthropic.com/en/docs/about-claude/models
            ---@type "claude-3-5-sonnet-latest"|"claude-3.5-haiku-latest"
            default = "claude-3-5-sonnet-latest",
          },
        },
        env = {
          api_key = vim.env.ANTHROPIC_API_KEY,
        },
      })
    end,

    ollama = function()
      return require("codecompanion.adapters").extend("ollama", {
        name   = "mistral",
        schema = {
          model = {
            default = vim.g.current_llm,
          },
        },
      })
    end,
  },

  strategies = {
    chat   = {
      adapter = "ollama",
    },
    inline = {
      adapter = "ollama",
    },
    agent  = {
      adapter = "ollama",
    },
  },
})
