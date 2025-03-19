-- -*-mode:lua-*- vim:ft=lua
local ok, lspconfig = pcall(require, "lspconfig")
if not ok then return end

return {
  cmd       = { "taplo", "lsp", "stdio" },
  filetypes = { "toml" },
  root_dir = function(fname)
    return lspconfig.util.root_pattern('*.toml')(fname)
      or vim.fs.dirname(vim.fs.find(".git", { path = fname, upward = true })[1])
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
