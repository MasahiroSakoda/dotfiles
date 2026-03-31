-- -*-mode:lua-*- vim:ft=lua

return {
  {
    "neovim/nvim-lspconfig",
    config = function() require("lsp.config") end,
  },
  { "folke/lazydev.nvim", ft = "lua", opts = {} },
  { "b0o/schemastore.nvim" },
  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    ft = { "typescript", "typescriptreact", "ypescript.tsx" },
    config = function() require("lsp.config.typescript") end,
  },
}
