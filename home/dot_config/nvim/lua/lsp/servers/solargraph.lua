-- -*-mode:lua-*- vim:ft=lua
local ok, lspconfig = pcall(require, "lspconfig")
if not ok then return end

local ft = require("user.filetypes")
return {
  cmd = { "solargraph", "stdio" },
  filetypes = { "ruby" },
  root_dir  = lspconfig.util.root_pattern(ft.lsp.ruby),

  settings = {
    solargraph = {
      hint = { enable = true },
      diagnostics = true,
      formatting  = true,
      completion  = true,
    },
  },
}
