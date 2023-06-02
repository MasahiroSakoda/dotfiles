local ok, lspconfig = pcall(require, "lspconfig")
if not ok then return end

return {
  cmd       = {
    "clangd",
    "--clang-tidy",
    "--log=verbose",
    "--enable-config", -- clangd 11+ supports reading from .clangd configuration file
    "--background-index",
    "--pch-storage=memory",
    "--all-scopes-completion",
    "--completion-style=detailed",
    "--suggest-missing-includes",
    "--cross-file-rename",
    "--folding-ranges",
    "--fallback-style=llvm",
    "--offset-encoding=utf-16", -- for 'multiple client offset encoding' error
  },
  filetypes = {
    "c", "h",
    "cpp", "hpp", "c++", "h++",
    "cppm", "cxxm",
    "objc", "objcpp"
  },
  root_dir = function(filename)
   return  lspconfig.util.root_pattern(
    "src",
    ".clangd",
    ".clang-tidy",
    -- ".clang-format",
    "compile_commands.json",
    "compile_flags.txt",
    "configure.ac",
    ".git")(filename) or vim.fn.getcwd()
  end,
  single_file_support = true,
}
