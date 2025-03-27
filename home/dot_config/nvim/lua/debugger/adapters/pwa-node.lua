-- -*-mode:lua-*- vim:ft=lua
local mason = require("mason-registry")
local pkg = "js-debug-adapter"

return {
  type = "server",
  host = "localhost",
  port = "${port}",
  executable = {
    command = "node",
    args    = { mason.get_package(pkg):get_install_path() .. "/js-debug/src/dapDebugServer.js", "${port}" },
  },
}
