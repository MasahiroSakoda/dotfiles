-- -*-mode:lua-*- vim:ft=lua

return {
  -- chezmoi integration
  {
    "xvzc/chezmoi.nvim",
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function() require("user.chezmoi") end,
  },
  {
    "stevearc/overseer.nvim",
    cmd = { "Grep", "Make", "OverseerToggle", "OverseerRun" },
    config = function() require("user.overseer") end,
  },
}
