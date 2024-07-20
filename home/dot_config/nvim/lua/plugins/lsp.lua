-- -*-mode:lua-*- vim:ft=lua

return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "williamboman/mason.nvim", config = function() require("lsp.config.mason") end },
      { "williamboman/mason-lspconfig.nvim" },
      { "folke/neodev.nvim", config = function() require("lsp.config.neodev") end },
    },
    event  = { "BufReadPre", "BufNewFile" },
    config = function() require("lsp.config") end,
  },
  { "folke/neoconf.nvim", cmd = "Neoconf", config = function() require("lsp.config.neoconf") end },
  {
    "nvimtools/none-ls.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    event  = { "BufReadPre", "BufNewFile" },
    config = function() require("lsp.config.null-ls") end,
  },
  {
    "SmiteshP/nvim-navic",
    dependencies = { "neovim/nvim-lspconfig" },
    cond   = not vim.g.vscode,
    config = function() require("lsp.config.navic") end,
  },
  -- Rich GUI for LSP
  {
    "nvimdev/lspsaga.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons", "nvim-treesitter/nvim-treesitter" },
    event = "LspAttach",
    config = function() require("lsp.config.lspsaga") end,
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    dependencies = { "williamboman/mason.nvim", "mfussenegger/nvim-dap" },
    cmd    = { "DapInstall", "DapUninstall" },
    config = function() require("dap.config.mason-dap") end,
  },
  -- Status GUI for LSP
  { "j-hui/fidget.nvim", event = "LspAttach", config = function() require("lsp.config.fidget") end },
  -- Display diagnostics
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cond   = not vim.g.vscode,
    cmd    = { "Trouble" },
    config = function() require("lsp.config.trouble") end,
  },

}
