-- -*-mode:lua-*- vim:ft=lua
local avante_ok, avante = pcall(require, "avante")
if not avante_ok then return end

avante.setup({
  ---@type Provider "claude" | "openai" | "azure" | "gemini" | "cohere" | "copilot" | string
  provider = "ollama",

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
