-- -*-mode:lua-*- vim:ft=lua

return {
  cmd       = { "yaml-language-server", "--stdio" },
  root_dir  = function(fname)
    return vim.fs.dirname(vim.fs.find(".git", { path = fname, upward = true })[1])
  end,
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
