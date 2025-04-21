-- -*-mode:lua-*- vim:ft=lua

return {
  {
    "williamboman/mason.nvim",
    cmd = { "Mason" },
    config = function() require("lsp.config.mason") end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    event  = { "BufReadPre", "BufNewFile" },
    config = function() require("lsp.config") end,
  },
  { "neovim/nvim-lspconfig" },
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
  { "b0o/SchemaStore.nvim" },
}
