-- -*-mode:lua-*- vim:ft=lua

---@type vim.lsp.Config
return {
  cmd          = { "cmake-language-server" },
  filetypes    = { "cmake" },
  root_markers = { ".git" },
  init_options = {
    buildDirectory = "build"
  },
}
