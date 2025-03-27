-- -*-mode:lua-*- vim:ft=lua
local pkg = "bash-debug-adapter"

return {
  {
    name    = "Launch file",
    type    = "bashdb",
    request = "launch",
    program = "${file}",
    pathBashdb   = require("mason-registry").get_package(pkg):get_install_path() .. "/extension/bashdb_dir/bashdb",
    pathBashLib  = require("mason-registry").get_package(pkg):get_install_path() .. "/extension/bashdb_dir",
    cwd     = "${workspaceFolder}",
    stopOnEntry   = false,
    runInTerminal = false,
  }
}
