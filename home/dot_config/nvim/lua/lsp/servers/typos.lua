-- -*-mode:lua-*- vim:ft=lua

local ok, lspconfig = pcall(require, "lspconfig")
if not ok then return end

return {
  cmd = { "typos-lsp" },
  root_dir = lspconfig.util.root_pattern("typos.toml", ".typos.toml", "_typos.toml"),
  filetypes = { "*" },
  init_options = {
    config = vim.fn.expand("~/.config/nvim/spell/typos.toml"),
    diagnosticSeverity = "Hint",
  },
}
