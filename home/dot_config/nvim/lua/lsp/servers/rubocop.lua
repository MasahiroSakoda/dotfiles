local ok, lspconfig = pcall(require, "lspconfig")
if not ok then return end

return {
  cmd       = { "bundle", "exec", "rubocop", "-lsp" },
  filetypes = { "ruby" },
  root_dir  = function(filename)
    return lspconfig.util.root_pattern(
      ".rubocop.yml",
      "Gemfile",
      ".git"
    )(filename) or vim.fn.getcwd()
  end,
  single_file_support = true,
}
