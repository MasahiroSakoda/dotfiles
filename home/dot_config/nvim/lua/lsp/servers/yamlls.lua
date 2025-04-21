-- -*-mode:lua-*- vim:ft=lua

---@type vim.lsp.Config
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
      schemas     = require("schemastore").yaml.schemas(),
      schemastore = { enabled = false, url = "" },
      format      = { enabled = true, singleQuote = false },
      validate    = true,
      completion  = true,
      hover       = true
    },
  },
}
