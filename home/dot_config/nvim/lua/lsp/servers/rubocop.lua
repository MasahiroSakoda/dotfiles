-- -*-mode:lua-*- vim:ft=lua
local ok, lspconfig = pcall(require, "lspconfig")
if not ok then return end

local ft = require("user.filetypes")
return {
  cmd       = { "rubocop", "-lsp" },
  filetypes = { "ruby" },
  root_dir  = lspconfig.util.root_pattern(ft.lsp.ruby),
  single_file_support = true,
}
