-- -*-mode:lua-*- vim:ft=lua

---@type vim.lsp.Config
return {
  cmd          = { "bash-language-server", "start" },
  filetypes    = { "sh", "bash", "zsh" },
  root_markers = { ".git" },
  autostart = true,

  settings = {
    bashIde = {
      globPattern = "*@(.sh|.inc|.bash|.command|.zsh)",
      includeAllWorkspaceSymbols = true,
    },
  },
}
