-- -*-mode:lua-*- vim:ft=lua
local ft = require("user.filetypes")

---@type vim.lsp.Config
return {
  cmd          = vim.fn.executable("pnpm") and { "pnpm", "biome", "lsp-proxy" } or { "npx", "biome", "lsp-proxy" },
  filetypes    = ft.lang.js,
  root_markers = ft.lsp.biome,
}
