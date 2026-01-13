-- -*-mode:lua-*- vim:ft=lua
local ok, sidekick = pcall(require, "sidekick")
if not ok then return end

vim.g.sidekick_nes = false

---@class sidekick.Config
sidekick.setup({
  nes = {
    enabled = function(_)
      return vim.g.sidekick_nes ~= false and vim.b.sidekick_nes ~= false
    end,
    debounce = 500,
  },
  cli = {
    watch = true,

    ---@type table<string, sidekick.cli.Config|{}>
    tools = {
      opencode = {
        cmd = { "opencode" },
        ---@see https://opencode.ai/docs/themes/#built-in-themes
        env = { OPENCODE_THEME = "tokyonight" },
      },
    },
  },

  prompts = require("ai.sidekick.prompts"),

  ---@class sidekick.cli.Mux
  mux = {
    backend = vim.env.ZELLIJ and "zellij" or "tmux", -- default to tmux unless zellij is detected
    enabled = true,
  },
})
