local ok, lspconfig = pcall(require, "lspconfig")
if not ok then return end

return {
  cmd       = {
    "clangd",
    "--offset-encoding=utf-16", -- for 'multiple client offset encoding' error
    "--all-scopes-completion",
    "--background-index",
    "--pch-storage=disk",
    "--log=verbose",
    "--completion-style=detailed",
    "--enable-config", -- clangd 11+ supports reading from .clangd configuration file
    "--clang-tidy",
    "--query-driver=/home/linuxbrew/.linuxbrew/Cellar/gcc/11.3.0_2",
    "--clang-tidy-checks=-*,llvm-*,clang-analyzer-*,modernize-*,-modernize-use-trailing-return-type",
    -- "--fallback-style=Google",
    -- "--compile-commands-dir=build",
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
