-- -*-mode:lua-*- vim:ft=lua
local pkg = "js-debug-adapter"

return {
  type = "server",
  host = "localhost",
  port = "${port}",
  executable = {
    command = "node",
    args = { vim.fn.stdpath("data") .. "/mason/" .. pkg .. "/js-debug/src/dapDebugServer.js", "${port}" },
  },
}
