-- -*-mode:lua-*- vim:ft=lua

---@type vim.lsp.Config
return {
	cmd = { "stylua", "--lsp", "--search-parent-directories" },
	filetypes = { "lua" },
	root_markers = { ".stylua.toml", "stylua.toml", ".editorconfig" },
}
