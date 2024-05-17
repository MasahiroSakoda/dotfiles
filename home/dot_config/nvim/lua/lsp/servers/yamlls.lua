-- -*-mode:lua-*- vim:ft=lua
local ok, lspconfig = pcall(require, "lspconfig")
if not ok then return end

return {
  cmd       = { "yaml-language-server", "--stdio" },
  root_dir  = lspconfig.util.find_git_ancestor,
  filetypes = { "yaml", "yml", "yaml.docker-compose" },
  settings  = {
    -- https://github.com/redhat-developer/vscode-redhat-telemetry#how-to-disable-telemetry-reporting
    redhat = { telemetry = { enabled = false } },
    yaml = {
      keyOrdering = false,
      schemaStore = {
        enable = true,
        url = "https://www.schemastore.org/api/json/catalog.json",
      },
      format = {
        enabled = true,
        singleQuote = false,
      },
      validate = true,
      completion = true,
      hover = true
    },
  },
}
