local ok, lspconfig = pcall(require, "lspconfig")
if not ok then return end

local filetypes = require("user.filetypes")

return {
  cmd       = { "bundle", "exec", "rubocop", "-lsp" },
  filetypes = { "ruby" },
  root_dir  = function(filename)
    return lspconfig.util.root_pattern(
      filetypes.rubocop,
      "Gemfile",
      ".git"
    )(filename) or vim.fn.getcwd()
  end,
  single_file_support = true,
}
