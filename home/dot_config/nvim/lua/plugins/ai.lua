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
        ft = { "markdown", "markdown.mdc", "markdown.mdx", "vimwiki", "codecompanion" },
        config = require("user.render-markdown"),
      },
    },
    cond = not vim.g.vscode,
    cmd = {
      "CodeCompanion",
      "CodeCompanionActions",
      "CodeCompanionChat",
      "CodeCompanionToggle",
      "CodeCompanionHistorySave",
      "CodeCompanionHistoryLoad",
    },
    config = function() require("ai.codecompanion") end,
  },
  {
    "ravitemer/mcphub.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd    = "MCPHub",
    build  = "pnpm install -g mcp-hub@latest",
    config = function() require("ai.mcp.mcphub") end,
  },
}
