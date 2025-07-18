-- -*-mode:lua-*- vim:ft=lua

---@type vim.lsp.Config
return {
  cmd          = { "marksman", "server" },
  filetypes    = { "md", "markdown", "mdx" },
  root_markers = { ".git" },
  single_file_support = true,
}
