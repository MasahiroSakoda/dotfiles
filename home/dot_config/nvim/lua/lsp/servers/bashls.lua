-- -*-mode:lua-*- vim:ft=lua

return {
  cmd       = { "bash-language-server", "start" },
  filetypes = { "sh", "bash", "zsh" },
  root_dir = vim.lsp.util.find_git_ancestor,
  autostart = true,

  settings = {
    bashIde = {
      globPattern = "*@(.sh|.inc|.bash|.command|.zsh)",
      includeAllWorkspaceSymbols = true,
    },
  },
}
