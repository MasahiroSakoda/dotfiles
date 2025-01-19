-- -*-mode:lua-*- vim:ft=lua

return {
  --  AI-powered coding
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",

      -- Optional plugins
      "stevearc/dressing.nvim",        -- Improves `vim.ui.select`
      { "MeanderingProgrammer/render-markdown.nvim", ft = { "markdown", "codecompanion" } },
    },
    cond = not vim.g.vscode,
    cmd = { "CodeCompanion", "CodeCompanionActions", "CodeCompanionAdd", "CodeCompanionChat", "CodeCompanionToggle" },
    config = function() require("ai.codecompanion") end,
  },
}
