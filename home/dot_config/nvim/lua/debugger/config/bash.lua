-- -*-mode:lua-*- vim:ft=lua
local package = "bash-debug-adapter"

return {
  {
    name    = "Launch file",
    type    = "bashdb",
    request = "launch",
    program = "${file}",
    pathBashdb  = vim.fn.stdpath("data") .. "/mason/packages/" .. package .. "/extension/bashdb_dir/bashdb",
    pathBashLib  = vim.fn.stdpath("data") .. "/mason/packages/" .. package .. "/extension/bashdb_dir",
    cwd     = "${workspaceFolder}",
    stopOnEntry   = false,
    runInTerminal = false,
  }
}
