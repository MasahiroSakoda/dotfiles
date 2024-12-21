local lspconfig_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_ok then return end

return {
  cmd       = { "terraform-ls", "serve" },
  filetypes = require("user.filetypes").lsp.terraform,
  root_dir  = lspconfig.util.root_pattern(".terraform", ".git"),
  settings  = {},
}
