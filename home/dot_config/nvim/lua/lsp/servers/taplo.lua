-- -*-mode:lua-*- vim:ft=lua
local ok, lspconfig = pcall(require, "lspconfig")
if not ok then return end

return {
  cmd       = { "taplo", "lsp", "stdio" },
  filetypes = { "toml" },
  root_dir = function(fname)
    return lspconfig.util.root_pattern('*.toml')(fname) or lspconfig.util.find_git_ancestor(fname)
  end,
  settings = {
    evenBetterToml = {
      schema = {
        enabled = true,
        repositoryEnabled = true,
        repositoryUrl = "https://taplo.tamasfe.dev/schema_index.json",
      },
      cachePath = vim.fn.stdpath("cache") .. "/taplo",
    },
  }
}
