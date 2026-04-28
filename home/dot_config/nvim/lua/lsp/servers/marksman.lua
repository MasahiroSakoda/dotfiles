-- -*-mode:lua-*- vim:ft=lua

---@type vim.lsp.Config
return {
  cmd          = { "marksman", "server" },
  filetypes    = { "markdown", "markdown.mdx", "vimwiki" },
  root_markers = { ".git" },
  single_file_support = true,
}
