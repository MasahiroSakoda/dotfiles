local ok, lspconfig = pcall(require, "lspconfig")
if not ok then return end

local function organize_imports()
  local params = {
    command = 'pyright.organizeimports',
    arguments = { vim.uri_from_bufnr(0) },
  }
  vim.lsp.buf.execute_command(params)
end

return {
  cmd       = { "pyright-langserver", "--stdio" },
  filetypes = { "python" },
  root_dir  = function(filename)
    return lspconfig.util.root_pattern(
      -- "pyproject.toml",
      "pyrightconfig.json"
      -- "Pipfile",
      -- "setup.py",
      -- "setup.cfg",
      -- "requirements.txt"
    )(filename) or vim.fn.getcwd()
  end,
  single_file_support = true,
  settings = {
    python = {
      analysis = {
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
        diagnosticMode = 'workspace',
      },
    },
  },
  commands = {
    PyrightOrganizeImports = {
      organize_imports,
      description = 'Organize Imports',
    },
  }
}
