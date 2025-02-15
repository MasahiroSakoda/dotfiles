-- -*-mode:lua-*- vim:ft=lua

return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "williamboman/mason.nvim", config = function() require("lsp.config.mason") end },
      { "williamboman/mason-lspconfig.nvim" },
    },
    event  = { "BufReadPre", "BufNewFile" },
    config = function() require("lsp.config") end,
  },
  { "folke/lazydev.nvim", ft = "lua", opts = {} },
  {
    "nvimtools/none-ls.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    cond   = not vim.g.vscode,
    event  = { "BufReadPre", "BufNewFile" },
    config = function() require("lsp.config.null-ls") end,
  },
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cond   = not vim.g.vscode,
    cmd    = { "Trouble" },
    config = function() require("lsp.config.trouble") end,
  },

}
