local ok, lspconfig = pcall(require, "lspconfig")
if not ok then return end

return {
  cmd       = { "vim-language-server", "--stdio" },
  filetypes = { "vim" },
  root_dir  = function(filename)
    return lspconfig.util.find_git_ancestor(filename) or vim.loop.os_homedir()
  end,
  init_options = {
    diagnostic = { enable = true },
    indexes = {
      count = 3,
      gap   = 100,
      projectRootPatterns = { "runtime", "nvim", ".git", "autoload", "plugin" }
    },
    iskeyword = "@,48-57,_,192-255,-#",
    runtimepath = "",
    suggest = {
      fromRuntimepath = true,
      fromVimruntime  = true
    },
    vimruntime = '',
  },
  settings  = {},
}
