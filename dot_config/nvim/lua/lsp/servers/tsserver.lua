local ok, lspconfig = pcall(require, "lspconfig")
if not ok then return end

return {
  cmd       = { "typescript-language-server", "--stdio" },
  root_dir  = function (filename)
    return lspconfig.util.root_pattern(
      "jsconfig.json",
      "tsconfig.json",
      "package.json"
    )(filename) or vim.fn.getcwd()
  end,
  autostart = false,
  filetypes = {
    "javascript",
    "javascript.jsx",
    "javascriptreact",
    "typescript",
    "typescript.tsx",
    "typescriptreact",
  },
}
