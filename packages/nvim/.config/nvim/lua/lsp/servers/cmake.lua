local ok, lspconfig = pcall(require, "lspconfig")
if not ok then return end

return {
  cmd       = { "cmake-language-server" },
  filetypes = { "cmake" },
  root_dir = lspconfig.util.root_pattern("compile_commands.json", "build", "makefile", "README.md"),
  init_options = {
    buildDirectory = "build"
  },
}
