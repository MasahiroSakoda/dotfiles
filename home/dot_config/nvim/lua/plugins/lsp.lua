-- -*-mode:lua-*- vim:ft=lua

return {
  { "neovim/nvim-lspconfig" },
  { "folke/lazydev.nvim", ft = "lua", opts = {} },
  {
    "nvimtools/none-ls.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    cond   = not vim.g.vscode,
    event  = { "BufReadPre", "BufNewFile" },
    config = function()
      require("lsp.config")
      require("lsp.config.null-ls")
    end,
  },
  { "b0o/schemastore.nvim" },
}
