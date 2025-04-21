-- -*-mode:lua-*- vim:ft=lua
local ok, lspconfig = pcall(require, "lspconfig")
if not ok then return end

local ft = require("user.filetypes")

---@type vim.lsp.Config
return {
  filetypes = ft.lang.js,
  root_dir  = lspconfig.util.root_pattern(ft.lsp.biome),

  on_new_config = function(new_config)
    local pnpm = lspconfig.util.root_pattern("pnpm-lock.yml", "pnpm-lock.yaml")(vim.api.nvim_buf_get_name(0))
    local cmd  = pnpm and { "pnpm", "biome", "lsp-proxy" } or { "npx", "biome", "lsp-proxy" }
    new_config.cmd = cmd
  end,
}
