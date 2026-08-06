---@type vim.lsp.Config
return {
  cmd          = { "vtsls", "--stdio" },
  filetypes    = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
  root_markers = { "package.json", "tsconfig.json", ".git" },
  single_file_support = true,
}
