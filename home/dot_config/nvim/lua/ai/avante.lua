-- -*-mode:lua-*- vim:ft=lua
local avante_ok, avante = pcall(require, "avante")
if not avante_ok then return end

avante.setup({
  ---@type Provider "claude" | "openai" | "azure" | "gemini" | "cohere" | "copilot" | string
  provider = "ollama",

  claude = {
    endpoint = "https://api.anthropic.com",
    ---@see https://docs.anthropic.com/en/docs/about-claude/models
    ---@type "claude-3-5-sonnet-latest"|"claude-3.5-haiku-latest"
    model    = "claude-3-5-sonnet-latest",
    timeout  = 30000, -- Timeout in milliseconds
    temperature  = 0,
    max_tokens   = 4096,
    api_key_name = vim.env.ANTHROPIC_API_KEY,
  },
  openai = {
    endpoint = "https://api.openai.com/v1",
    ---@see https://platform.openai.com/docs/models
    ---@type "gpt-3.5-turbo"|"gpt-4o"|"gpt-4o-mini"
    model    = "gpt-4o",
    timeout  = 30000, -- Timeout in milliseconds
    temperature  = 0,
    max_tokens   = 4096,
    api_key_name = vim.env.OPENAI_API_KEY,
  },
  copilot = {
    endpoint = "https://api.githubcopilot.com",
    ---@see https://api.githubcopilot.com/models
    ---@type "gpt-3.5-turbo"|"gpt-4o"|"o1-mini"
    model    = "o1-mini",
    proxy    = nil,         -- [protocol://]host[:port] Use this proxy
    allow_insecure = false, -- Allow insecure server connections
    timeout        = 30000, -- Timeout in milliseconds
    temperature    = 0,
    max_tokens     = 4096,
    api_key_name   = vim.env.COPILOT_API_KEY,
  },
  azure = {
    endpoint = string.format("https://%s.openai.azure.com", vim.env.AZURE_API_ENDPOINT),
    deployment   = vim.env.AZURE_API_DEPLOY,
    api_version  = vim.env.AZURE_API_VERSION,
    timeout      = 30000, -- Timeout in milliseconds
    temperature  = 0,
    max_tokens   = 4096,
    api_key_name = vim.env.AZURE_OPENAI_API_KEY,
  },
  gemini = {
    endpoint = "https://generativelanguage.googleapis.com/v1beta/models",
    ---@see https://ai.google.dev/gemini-api/docs/models/gemini
    ---@type "gemini-1.5-flash"|"gemini-1.5-flash-8b"|"gemini-1.5-pro"
    model    = "gemini-1.5-pro",
    timeout  = 30000, -- Timeout in milliseconds
    temperature  = 0,
    max_tokens   = 4096,
    api_key_name = vim.env.GEMINI_API_KEY,
  },
  cohere = {
    endpoint = "https://api.cohere.com/v2",
    ---@see https://docs.cohere.com/v2/docs/models
    ---@type "command-r-plus"
    model    = "command-r-plus",
    timeout  = 30000, -- Timeout in milliseconds
    temperature  = 0,
    max_tokens   = 3072,
    api_key_name = vim.env.COHERE_API_KEY,
  },

  -- Custom providers
  vendors = {
    ---@type AvanteProvider
    ollama = {
      endpoint = "127.0.0.1:11434/v1",
      model    = "mistral:latest", ---@type "codegemma:2b"|"phi3.5:3.8b"|"mistral:latest"

      parse_curl_args = function(opts, code_opts)
        return {
          url = opts.endpoint .. "/chat/completions",
          headers = {
            ["Accept"]       = "application/json",
            ["Content-Type"] = "application/json",
            ["x-api-key"]    = "ollama",
          },
          body = {
            model = opts.model,
            -- you can make your own message, but this is very advanced
            messages   = require("avante.providers").copilot.parse_messages(code_opts),
            max_tokens = 2048,
            stream     = true,
          },
        }
      end,
      parse_response_data = function(data_stream, event_state, opts)
        require("avante.providers").openai.parse_response(data_stream, event_state, opts)
      end,
      api_key_name = "",
    }
  },

  mappings = {
    --- @class AvanteConflictMappings
    diff = {
      ours       = "co",
      theirs     = "ct",
      all_theirs = "ca",
      both       = "cb",
      cursor     = "cc",
      next       = "]x",
      prev       = "[x",
    },
    suggestion = {
      accept  = "<M-l>",
      next    = "<M-]>",
      prev    = "<M-[>",
      dismiss = "<C-]>",
    },
    jump = {
      next = "]]",
      prev = "[[",
    },
    submit = {
      normal = "<CR>",
      insert = "<C-s>",
    },
  },
  hints = { enabled = true },
})
