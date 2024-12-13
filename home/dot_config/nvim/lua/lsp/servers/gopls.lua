local ok, lspconfig = pcall(require, "lspconfig")
if not ok then return end

return {
  cmd       = { "gopls", "serve" },
  filetypes = { "go", "gomod", "gotmpl" },
  root_dir  = lspconfig.util.root_pattern("go.mod", "go.work", ".git"),
  settings  = {
    gopls = {
      ---@See https://github.com/golang/tools/blob/master/gopls/doc/settings.md
      gofumpt = true,
      semanticTokens = true,
      staticcheck = true,
      directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules" },

      -- Completion settings
      usePlaceholders = true,
      completeUnimported = true,
      experimentalPostfixCompletions = true,
      completionDocumentation = true,
      deepCompletion = true,

      -- Inlay hints
      ["ui.inlayhint.hints"] = {
        assignVariableTypes = true,
        compositeLiteralFields = true,
        constantValues = true,
        parameterNames = true,
        rangeVariableTypes = true,
      },

      -- codelens
      codelenses = {
        generate = true, -- show the `go generate` lens.
        gc_details = false, --  // Show a code lens toggling the display of gc's choices.
        test = true,
        tidy = true,
        vendor = true,
        upgrade_dependency = true,
      },

      analyses = {
        nilness      = true,
        shadow       = true,
        unreachable  = true,
        unusedparams = true,
        unusedwrite  = true,
        useany       = true,
      },
      buildFlags = { os.getenv("GOFLAGS") }
    },
  },
  autostart = true,
  single_file_support = true,
}
