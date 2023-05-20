local ok, lspconfig = pcall(require, "lspconfig")
if not ok then return end

return {
  cmd       = { "docker-langserver", "--stdio" },
  filetypes = { "Dockerfile", "dockerfile" },
  root_dir  = lspconfig.util.root_pattern("Dockerfile"),
  log_level = vim.lsp.protocol.MessageType.Warning,
  single_file_support = true,
  settings  = {},
}
