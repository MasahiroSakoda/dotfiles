local ok, lspconfig = pcall(require, "lspconfig")
if not ok then return end

local filetypes = require("user.filetypes")

return {
  cmd       = { "bundle", "exec", "rubocop", "-lsp" },
  filetypes = { "ruby" },
  root_dir  = function(filename)
    local pattern = vim.tbl_extend("force", filetypes.rubocop, { "Gemfile", ".git" })
    return lspconfig.util.root_pattern(pattern)(filename) or vim.fn.getcwd()
  end,
  single_file_support = true,
}
