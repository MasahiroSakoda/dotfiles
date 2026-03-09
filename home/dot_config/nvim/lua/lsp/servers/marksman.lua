-- -*-mode:lua-*- vim:ft=lua

---@type vim.lsp.Config
return {
  cmd          = { "marksman", "server" },
  filetypes    = { "markdown" },
  root_markers = { ".git" },
  single_file_support = true,
}
