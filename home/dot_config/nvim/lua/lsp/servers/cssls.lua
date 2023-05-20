local ok, lspconfig = pcall(require, "lspconfig")
if not ok then return end

return {
  cmd       = { "vscode-css-language-server", "--stdio" },
  filetypes = { "css", "scss", "less" },
  root_dir  = function (filename)
    return lspconfig.util.root_pattern(
      "package.json",
      ".gitignore",
      ".git",
      "README.md",
      "src")(filename) or vim.fn.getcwd()
  end,

  settings = {
    css  = { validate = true },
    less = { validate = true },
    scss = { validate = true },
  }
}
