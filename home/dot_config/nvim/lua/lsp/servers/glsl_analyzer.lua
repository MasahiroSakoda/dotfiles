-- -*-mode:lua-*- vim:ft=lua

---@type vim.lsp.Config
return {
  cmd          = { "glsl_analyzer" },
  filetypes    = require("user.filetypes").lang.glsl,
  root_markers = { ".git" },
  capabilities = {
    textDocument = {
      completion = { editsNearCursor = true },
    },
    offsetEncoding = { "utf-8", "utf-16" },
  },
}
