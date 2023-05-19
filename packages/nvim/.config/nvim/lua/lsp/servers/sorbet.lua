local ok, lspconfig = pcall(require, "lspconfig")
if not ok then return end

return {
  cmd       = { "srb", "tc", "--lsp" },
  filetypes = { "ruby" },
  root_dir  = lspconfig.util.root_pattern("Gemfile", ".git"),
}
