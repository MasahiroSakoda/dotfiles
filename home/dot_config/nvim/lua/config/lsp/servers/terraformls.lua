-- -*-mode:lua-*- vim:ft=lua

---@type vim.lsp.Config
return {
  cmd          = { "terraform-ls", "serve" },
  filetypes    = require("config.editor.filetypes").lsp.terraform,
  root_markers = { ".terraform" },
  settings     = {
  },
}
