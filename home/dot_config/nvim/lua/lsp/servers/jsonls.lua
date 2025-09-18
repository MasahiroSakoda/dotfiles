-- -*-mode:lua-*- vim:ft=lua

---@type vim.lsp.Config
return {
  cmd          = { "vscode-json-language-server", "--stdio" },
  filetypes    = require("user.filetypes").lang.json,
  root_markers = { ".git" },
  init_options = { provideFormatter = false, documentRangeFormattingProvide = false },
  single_file_support = true,

  settings = {
    json = {
      schemas    = require("schemastore").json.schemas(),
      format     = { enable = false, singleQuote = false },
      validate   = { enable = true },
      completion = true,
      hover      = true,
    },
  },
}
