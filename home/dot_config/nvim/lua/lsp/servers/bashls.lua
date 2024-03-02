local ok, lspconfig = pcall(require, "lspconfig")
if not ok then return end

return {
  cmd       = { "bash-language-server", "start" },
  cmd_env   = { GLOB_PATTERN = "*@(.sh|.inc|.bash|.command)" },
  filetypes = { "sh" },
  root_dir  = lspconfig.util.root_pattern(".bashrc"),
  autostart = true,
}
