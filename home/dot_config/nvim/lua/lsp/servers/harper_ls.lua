---@type vim.lsp.Config
return {
  cmd = { "harper-ls", "--stdio" },
  filetypes = require("user.filetypes").lsp.happer,
  root_markers = { ".git" },
  single_file_support = true,
  capabilities = {
    semanticTokens = { multilineTokenSupport = true },
  },
  settings = {
    ["harper-ls"] = {
      diagnosticSeverity = "hint",
      linters = { SpellCheck = true, SentenceCapitalization = true },
      markdown = { IgnoreLinkTitle = false },
      dialect = "American",
      maxFileLength = 120000,
    },
  },
}
