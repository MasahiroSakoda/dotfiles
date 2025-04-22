-- -*-mode:lua-*- vim:ft=lua

---@type vim.lsp.Config
return {
  cmd          = { "typos-lsp" },
  filetypes    = { "*" },
  root_markers = { ".git" },
  init_options = {
    config = vim.fn.expand("~/.config/nvim/spell/typos.toml"),
    diagnosticSeverity = "Hint",
  },
}
