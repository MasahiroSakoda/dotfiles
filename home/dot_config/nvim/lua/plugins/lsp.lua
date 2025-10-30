-- -*-mode:lua-*- vim:ft=lua

return {
  {
    "mason-org/mason.nvim",
    cmd    = { "Mason", "MasonLog", "MasonInstall", "MasonUninstall", "MasonUninstallAll","MasonUpdate" },
    config = function() require("lsp.config.mason") end,
  },
  {
    "mason-org/mason-lspconfig.nvim",
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
  { "b0o/schemastore.nvim" },
}
