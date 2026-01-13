-- -*-mode:lua-*- vim:ft=lua

---@type vim.lsp.Config
return {
  cmd          = { "just-lsp" },
  filetypes    = { "just" },
  root_markers = { ".git" },
}
