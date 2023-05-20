local ok, lspconfig = pcall(require, "lspconfig")
if not ok then return end

return {
  cmd       = { "gopls", "serve" },
  filetypes = { "go", "gomod", "gotmpl" },
  root_dir  = lspconfig.util.root_pattern("go.mod", "go.work", ".git"),
  settings  = {
    gopls = {
      usePlaceholders = true,
      completeUnimported = true,
      experimentalPostfixCompletions = true,
      staticcheck = true,
      analyses = {
        unusedparams = true,
        shadow = false,
      }
    }
  },
  single_file_support = true,
}
