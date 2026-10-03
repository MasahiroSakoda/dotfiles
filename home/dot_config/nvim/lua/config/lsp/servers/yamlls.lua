-- -*-mode:lua-*- vim:ft=lua

---@type vim.lsp.Config
return {
  cmd          = { "yaml-language-server", "--stdio" },
  filetypes    = { "yaml" },
  settings  = {
    -- https://github.com/redhat-developer/vscode-redhat-telemetry#how-to-disable-telemetry-reporting
    redhat = { telemetry = { enabled = false } },
    yaml = {
      schemas = require("schemastore").yaml.schemas({
        ignore = { "GitHub Action" }
      }),
      keyOrdering = false,
      format  = {
        enabled        = true,
        singleQuote    = false,
        bracketSpacing = true,
        trailingComma  = true,
        proseWrap      = "preserve",
      },
      validate    = true,
      completion  = true,
      hover       = true
    },
  },
}
