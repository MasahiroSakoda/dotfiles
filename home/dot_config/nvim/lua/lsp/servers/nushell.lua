-- -*-mode:lua-*- vim:ft=lua

---@type vim.lsp.Config
return {
  cmd          = { "nu", "--lsp" },
  filetype     = { "nu" },
  root_markers = { ".git" },
  single_file_support = true,
}
