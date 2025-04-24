-- -*-mode:lua-*- vim:ft=lua

return {
  {
    "pwntester/octo.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "folke/snacks.nvim",
    },
    cmd    = { "Octo" },
    cond   = not vim.g.vscode,
    config = function() require("user.octo") end,
  },
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
  {
    "neo451/feed.nvim",
    dependencies = { "gregorias/coop.nvim" },
    cmd    = { "Feed" },
    cond   = not vim.g.vscode,
    config = function() require("user.feed") end,
  },

}
