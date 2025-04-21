-- -*-mode:lua-*- vim:ft=lua

---@type vim.lsp.Config
return {
  cmd          = { "docker-langserver", "--stdio" },
  filetypes    = { "Dockerfile", "dockerfile" },
  root_markers = { "Dockerfile", ".dockerignore" },
  log_level = vim.lsp.protocol.MessageType.Warning,
  single_file_support = true,
  settings  = {},
}
