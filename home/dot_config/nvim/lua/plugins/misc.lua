-- -*-mode:lua-*- vim:ft=lua

return {
  -- chezmoi integration
  {
    "xvzc/chezmoi.nvim",
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function() require("config.misc.chezmoi") end,
  },
  {
    "stevearc/overseer.nvim",
    version = "v2.*",
    cmd = { "Grep", "Make", "OverseerToggle", "OverseerRun" },
    config = function() require("config.misc.overseer") end,
  },
  {
    "obsidian-nvim/obsidian.nvim",
    config = function() require("config.misc.obsidian") end,
  },
  {
    "neo451/feed.nvim",
    cmd    = { "Feed" },
    cond   = not vim.g.vscode,
    config = function() require("config.misc.feed") end,
  },
}
