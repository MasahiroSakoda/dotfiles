-- -*-mode:lua-*- vim:ft=lua

return {
  cmd       = { "bash-language-server", "start" },
  filetypes = { "sh", "bash", "zsh" },
  root_dir  = function(fname)
    return vim.fs.dirname(vim.fs.find(".git", { path = fname, upward = true })[1])
  end,
  autostart = true,

  settings = {
    bashIde = {
      globPattern = "*@(.sh|.inc|.bash|.command|.zsh)",
      includeAllWorkspaceSymbols = true,
    },
  },
}
