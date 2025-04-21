-- -*-mode:lua-*- vim:ft=lua

---@type vim.lsp.Config
return {
  cmd       = { "vscode-json-language-server", "--stdio" },
  filetypes = require("user.filetypes").lang.json,
  root_dir  = function(fname)
    return vim.fs.dirname(vim.fs.find(".git", { path = fname, upward = true })[1])
  end,
  init_options = { provideFormatter = true },
  single_file_support = true,

  settings = {
    json = {
      schemas    = require("schemastore").json.schemas(),
      format     = { enable = true, singleQuote = false },
      validate   = { enable = true },
      completion = true,
      hover      = true,
    },
  },
}
