-- -*-mode:lua-*- vim:ft=lua

---@type vim.lsp.Config
return {
  cmd          = { "pyright-langserver", "--stdio" },
  filetypes    = { "python" },
  root_markers = require("user.filetypes").lsp.pyright,
  single_file_support = true,
  settings = {
    pyright = {
      disableLanguageServices = false,
      disableOrganizeImports  = true, -- Using Ruff's import organizer
    },
    python = {
      analysis = {
        typeCheckingMode = "off",
        -- Ignore all files for analysis to exclusively use Ruff for linting
        ignore = { "*" },
        diagnosticSeverityOverrides = {
          -- https://github.com/microsoft/pyright/blob/main/docs/configuration.md#type-check-diagnostics-settings
          reportUndefinedVariable = "none",
        },
      },
    },
  },
}
