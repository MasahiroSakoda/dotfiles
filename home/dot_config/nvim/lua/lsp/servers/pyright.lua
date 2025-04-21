-- -*-mode:lua-*- vim:ft=lua
local ok, lspconfig = pcall(require, "lspconfig")
if not ok then return end

local ft = require("user.filetypes")

---@type vim.lsp.Config
return {
  cmd       = { "pyright-langserver", "--stdio" },
  filetypes = { "python" },
  root_dir  = function(filename)
    return lspconfig.util.root_pattern(ft.lsp.pyright)(filename) or vim.fn.getcwd()
  end,
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
