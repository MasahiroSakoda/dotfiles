-- -*-mode:lua-*- vim:ft=lua

---@type vim.lsp.Config
return {
  cmd          = { "ruff", "server" },
  filetypes    = { "python" },
  root_markers = require("user.filetypes").lsp.ruff,
  autostart = true,
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
