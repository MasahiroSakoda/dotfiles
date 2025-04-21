-- -*-mode:lua-*- vim:ft=lua
local ok, lspconfig = pcall(require, "lspconfig")
if not ok then return end

---@type vim.lsp.Config
return {
  cmd       = { "sql-language-server", "up", "--method", "stdio" },
  filetypes = { "sql", "mysql" },
  root_dir  = lspconfig.util.root_pattern(".sqllsrc.json"),
  single_file_support = true,
  setrings  = {},
}
