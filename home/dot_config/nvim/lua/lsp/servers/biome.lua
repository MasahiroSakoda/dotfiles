-- -*-mode:lua-*- vim:ft=lua
local ft = require("user.filetypes")
local cmd = vim.fn.executable("pnpm") and "pnpm" or "npm"

---@type vim.lsp.Config
return {
  cmd       = { cmd, "biome", "lsp-proxy" },
  filetypes = {
    "javascript", "javascriptreact", "typescript", "typescriptreact",
    "json", "jsonc",
    "html", "css", "vue", "svelte", "astro",
  },
  root_markers = ft.lsp.biome,
}
