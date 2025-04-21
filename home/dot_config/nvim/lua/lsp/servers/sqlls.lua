-- -*-mode:lua-*- vim:ft=lua

---@type vim.lsp.Config
return {
  cmd          = { "sql-language-server", "up", "--method", "stdio" },
  filetypes    = { "sql", "mysql" },
  root_markers = { ".git" },
  single_file_support = true,
  setrings  = {},
}
