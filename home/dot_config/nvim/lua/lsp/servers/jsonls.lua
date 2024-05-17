-- -*-mode:lua-*- vim:ft=lua
local ok, lspconfig = pcall(require, "lspconfig")
if not ok then return end

return {
  cmd       = { "vscode-json-language-server", "--stdio" },
  filetypes = require("user.filetypes").lang.json,
  root_dir = lspconfig.util.find_git_ancestor,
  init_options = {
    provideFormatter = true,
  },
  single_file_support = true,

  settings = {
    json = {
      schemaStore = {
        enable = true,
        url = "https://www.schemastore.org/api/json/catalog.json",
      },
      format   = {
        enable = true,
        singleQuote = false,
      },
      validate = { enable = true },
      completion = true,
      hover = true,
    },
  },
}
