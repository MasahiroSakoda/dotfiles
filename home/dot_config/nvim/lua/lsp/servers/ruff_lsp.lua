-- -*-mode:lua-*- vim:ft=lua
local ok, lspconfig = pcall(require, "lspconfig")
if not ok then return end

local ft = require("user.filetypes")
return {
  cmd = { "ruff-lsp" },
  root_dir = function(filename)
    return lspconfig.util.root_pattern(ft.lsp.ruff)(filename) or vim.fn.getcwd()
  end,
  autostart = true,
  filetypes = { "python" },
  single_file_support = true,
}
