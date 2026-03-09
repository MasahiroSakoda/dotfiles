-- -*-mode:lua-*- vim:ft=lua

---@type vim.lsp.Config
return {
  cmd          = { "typos-lsp" },
  root_markers = { "typos.toml", ".typos.toml", "_typos.toml", ".git" },
  init_options = {
    config = vim.fn.expand("~/.config/nvim/spell/typos.toml"),
    diagnosticSeverity = "Hint",
  },
}
