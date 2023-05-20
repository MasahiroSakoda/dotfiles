local ok, lspconfig = pcall(require, "lspconfig")
if not ok then return end

return {
  root_dir  = function(filename)
    return lspconfig.util.root_pattern(
      "pyproject.toml",
      -- "pyrightconfig.json",
      "Pipfile",
      "setup.py",
      "setup.cfg",
      "requirements.txt"
    )(filename) or vim.fn.getcwd()
  end,
  settings = {
    -- Any extra CLI arguments for `ruff` go here.
    path = { "~/.local/share/nvim/mason/packages/ruff-lsp/venv/bin/ruff" },
    args = {},
  },
}
