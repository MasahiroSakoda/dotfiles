-- -*-mode:lua-*- vim:ft=lua

---@type vim.lsp.Config
return {
  cmd          = { "rubocop", "--lsp" },
  filetypes    = { "ruby" },
  root_markers = require("user.filetypes").lsp.ruby,
  single_file_support = true,
}
