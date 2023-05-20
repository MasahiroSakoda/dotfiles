local ok, lspconfig = pcall(require, "lspconfig")
if not ok then return end

return {
  cmd       = { "vscode-json-language-server", "--stdio" },
  filetypes = { "json", "jsonc" },
  root_dir  = function(filename)
    return lspconfig.util.root_pattern(
      "package.json",
      "README.md",
      ".gitignore",
      ".git"
    )(filename) or vim.fn.getcwd()
  end,
  init_options = {
    provideFormatter = true,
  },
  single_file_support = true,
}
