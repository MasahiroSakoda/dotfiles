-- -*-mode:lua-*- vim:ft=lua
local ok, sidekick = pcall(require, "sidekick")
if not ok then return end

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
  },

  ---@class sidekick.cli.Mux
  mux = {
    backend = vim.env.ZELLIJ and "zellij" or "tmux", -- default to tmux unless zellij is detected
    enabled = false,
  },
})
