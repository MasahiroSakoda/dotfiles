local ok, lspconfig = pcall(require, "lspconfig")
if not ok then return end

return {
  cmd       = { "gopls", "serve" },
  filetypes = { "go", "gomod", "gotmpl" },
  root_dir  = lspconfig.util.root_pattern("go.mod", "go.work", ".git"),
  settings  = {
    gopls = {
      -- Completion settings
      usePlaceholders = true,
      completeUnimported = true,
      experimentalPostfixCompletions = true,
      completionDocumentation = true,
      deepCompletion = true,

      -- the following diagnostics options are leave it to `revive`
      -- staticcheck = true,
      -- analyses = {
      --   unusedparams = true,
      --   unreachable  = true,
      --   shadow       = false,
      -- },
    },
  },
  autostart = true,
  single_file_support = true,
}
