-- -*-mode:lua-*- vim:ft=lua

---@type vim.lsp.Config
return {
  cmd          = { "docker-language-server", "--stdio" },
  filetypes    = { "Dockerfile", "dockerfile", "yaml.docker-compose" },
  get_language_id = function(_, ftype)
  end,
  root_markers = {
    "Dockerfile",
    "docker-compose.yaml", "docker-compose.yml", "compose.yaml", "compose.yml",
    "docker-bake.json", "docker-bake.hcl", "docker-bake.override.json", "docker-bake.override.hcl",
  },
  log_level = vim.lsp.protocol.MessageType.Warning,
  single_file_support = true,
  settings  = {},
}
