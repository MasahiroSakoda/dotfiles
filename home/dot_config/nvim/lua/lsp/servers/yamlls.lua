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
      schemas     = require("schemastore").yaml.schemas(),
      schemastore = { enabled = false, url = "" },
      format      = { enabled = true, singleQuote = false },
      validate    = true,
      completion  = true,
      hover       = true
    },
  },
}
