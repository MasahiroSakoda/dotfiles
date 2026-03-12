-- -*-mode:lua-*- vim:ft=lua

---@type vim.lsp.Config
return {
  cmd          = { "typos-lsp" },
  root_markers = { "typos.toml", ".typos.toml", "_typos.toml", ".git" },
  init_options = {
    diagnosticSeverity = "Hint",
  },
}
