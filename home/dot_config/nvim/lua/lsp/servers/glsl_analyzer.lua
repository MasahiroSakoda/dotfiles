-- -*-mode:lua-*- vim:ft=lua

return {
  cmd       = { "glsl_analyzer" },
  filetypes = { "glsl" },
  capabilities = {
    textDocument = {
      completion = { editsNearCursor = true },
    },
    offsetEncoding = { "utf-8", "utf-16" },
  },
}
