-- -*-mode:lua-*- vim:ft=lua

---@type vim.lsp.Config
return {
  cmd          = { "vim-language-server", "--stdio" },
  filetypes    = { "vim" },
  root_markers = { ".git" },
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
