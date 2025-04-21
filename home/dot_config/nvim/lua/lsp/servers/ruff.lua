-- -*-mode:lua-*- vim:ft=lua
local ok, lspconfig = pcall(require, "lspconfig")
if not ok then return end

---@type vim.lsp.Config
local ft = require("user.filetypes")
return {
  cmd = { "ruff", "server" },
  root_dir = function(filename)
    return lspconfig.util.root_pattern(ft.lsp.ruff)(filename) or vim.fn.getcwd()
  end,
  autostart = true,
  filetypes = { "python" },
  single_file_support = true,

  init_options = {
    settings = {
      fixAll = true,
      showNotification = true,
      organizeImports  = true,
      lint = {
        enable = true,
        preview = true,
      },
    },
  },
}
