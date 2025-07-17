-- -*-mode:lua-*- vim:ft=lua

---@type vim.lsp.Config
return {
  cmd          = { "yaml-language-server", "--stdio" },
  filetypes    = { "yaml", "yml", "yaml.docker-compose" },
  root_markers = { ".git" },
  settings  = {
    -- https://github.com/redhat-developer/vscode-redhat-telemetry#how-to-disable-telemetry-reporting
    redhat = { telemetry = { enabled = false } },
    yaml = {
      keyOrdering = false,
      schemastore = { enabled = true, url = "https://www.schemastore.org/api/json/catalog.json" },
      format      = { enabled = true, singleQuote = false },
      validate    = true,
      completion  = true,
      hover       = true
    },
  },
}
