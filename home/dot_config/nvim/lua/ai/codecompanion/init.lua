-- -*-mode:lua-*- vim:ft=lua
local ok, codecompanion = pcall(require, "codecompanion")
if not ok then return end

require("utils.ai")

codecompanion.setup({
  opts = {
    log_level = "TRACE",   ---@type "DEBUG"|"TRACE"
    language  = "English", ---@type "English"|"Japanese"
  },

  prompt_library = require("ai.codecompanion.prompts"),
  adapters       = require("ai.codecompanion.adapters"),

  strategies = {
    chat = {
      adapter = "ollama",
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
      show_settings  = false,
      show_header_separator = true,
    },
    diff = {
      layout   = "vertical", ---@type "horizontal"|"vertical"
      provider = "default",  ---@type "default"|"mini_diff"
    },
    inline = {
      layout = "vertical",   ---@type "vertical"|"horizontal"|"buffer"
    },
  },

  extensions = {},
})
