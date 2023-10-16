local ok, lspconfig = pcall(require, "lspconfig")
if not ok then return end

return {
  cmd = { "solargraph", "stdio" },
  settings = {
    solargraph = {
      diagnostics = true,
    },
  },
  init_options = { formatting = true },
  filetypes = { "ruby" },
  root_dir  = lspconfig.util.root_pattern("Gemfile", ".git"),
}
