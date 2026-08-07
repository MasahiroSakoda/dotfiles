-- -*-mode:lua-*- vim:ft=lua

return {
  {
    "neovim/nvim-lspconfig",
    event  = { "BufReadPre", "BufNewFile" },
    config = function() require("lsp.config") end,
  },
  { "folke/lazydev.nvim", ft = "lua", opts = {} },
  { "b0o/schemastore.nvim" },
}
