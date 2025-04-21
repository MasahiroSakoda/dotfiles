-- -*-mode:lua-*- vim:ft=lua

---@type vim.lsp.Config
return {
  cmd          = { "terraform-ls", "serve" },
  filetypes    = require("user.filetypes").lsp.terraform,
  root_markers = { ".terraform" },
  settings     = {},
}
