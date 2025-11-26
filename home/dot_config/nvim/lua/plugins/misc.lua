-- -*-mode:lua-*- vim:ft=lua

return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown", "markdown.mdc", "markdown.mdx", "vimwiki", "codecompanion" },
    config = require("user.render-markdown"),
  },
  -- chezmoi integration
  { "xvzc/chezmoi.nvim", dependencies = { 'nvim-lua/plenary.nvim' }, config = function() require("user.chezmoi") end },
  {
    "stevearc/overseer.nvim",
    version = "v2.*",
    cmd = { "Grep", "Make", "OverseerToggle", "OverseerRun" },
    config = function() require("user.overseer") end,
  },
  {
    "mistweaverco/kulala.nvim",
    ft     = { "http", "rest" },
    config = function() require("user.kulala") end,
  },
  {
    "neo451/feed.nvim",
    cmd    = { "Feed" },
    cond   = not vim.g.vscode,
    config = function() require("user.feed") end,
  },
}
