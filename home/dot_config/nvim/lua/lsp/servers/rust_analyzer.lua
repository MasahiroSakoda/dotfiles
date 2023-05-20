local ok, lspconfig = pcall(require, "lspconfig")
if not ok then return end

return {
  cmd       = { "rust-analyzer" },
  filetypes = { "rust" },
  root_dir  = lspconfig.util.root_pattern("Cargo.toml", "rust-project.json"),
  settings  = {
    ["rust-analyzer"] = {}
  }
}
