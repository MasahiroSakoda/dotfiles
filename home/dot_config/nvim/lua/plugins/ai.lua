-- -*-mode:lua-*- vim:ft=lua

return {
  --  AI-powered coding
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",

      -- Optional plugins
      {
        "MeanderingProgrammer/render-markdown.nvim",
        ft = { "markdown", "vimwiki", "codecompanion" },
        config = require("user.render-markdown"),
      },
    },
    cond = not vim.g.vscode,
    cmd = { "CodeCompanion", "CodeCompanionActions", "CodeCompanionAdd", "CodeCompanionChat", "CodeCompanionToggle" },
    config = function() require("ai.codecompanion") end,
  },
}
