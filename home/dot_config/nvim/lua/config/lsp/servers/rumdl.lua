-- -*-mode:lua-*- vim:ft=lua

---@type vim.lsp.Config
return {
  cmd          = { "rumdl", "server" },
  filetypes    = { "markdown" },
  root_markers = { ".rumdl.toml", "rumdl.toml", ".markdownlint.json", ".markdownlint.yaml" },
  single_file_support = true,
}
