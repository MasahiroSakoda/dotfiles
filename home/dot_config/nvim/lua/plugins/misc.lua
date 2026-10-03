-- -*-mode:lua-*- vim:ft=lua

return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown", "markdown.mdc", "markdown.mdx", "vimwiki" },
    config = function() require("config.editor.render-markdown") end,
  },
  -- chezmoi integration
  { "xvzc/chezmoi.nvim", dependencies = { 'nvim-lua/plenary.nvim' }, config = function() require("config.misc.chezmoi") end },
  {
    "stevearc/overseer.nvim",
    version = "v2.*",
    cmd = { "Grep", "Make", "OverseerToggle", "OverseerRun" },
    config = function() require("config.misc.overseer") end,
  },
  {
    "neo451/feed.nvim",
    cmd    = { "Feed" },
    cond   = not vim.g.vscode,
    config = function() require("config.misc.feed") end,
  },
}
