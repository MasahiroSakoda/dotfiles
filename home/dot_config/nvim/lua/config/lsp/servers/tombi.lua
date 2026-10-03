-- -*-mode:lua-*- vim:ft=lua

---@type vim.lsp.Config
return {
  cmd          = { "tombi", "lsp" },
  filetypes    = { "toml" },
  root_markers = require("config.filetypes").lsp.tombi,
}
