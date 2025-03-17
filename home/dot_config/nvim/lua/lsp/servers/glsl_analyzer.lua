-- -*-mode:lua-*- vim:ft=lua

return {
  cmd       = { "glsl_analyzer" },
  filetypes = require("user.filetypes").lang.glsl,
  capabilities = {
    textDocument = {
      completion = { editsNearCursor = true },
    },
    offsetEncoding = { "utf-8", "utf-16" },
  },
}
