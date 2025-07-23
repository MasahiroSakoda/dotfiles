-- -*-mode:lua-*- vim:ft=lua
local pkg = "chrome-debug-adapter"

return {
  type = "server",
  host = "localhost",
  port = "${port}",
  executable = {
    command = "node",
    args = { vim.fn.stdpath("data") .. "/mason/" .. pkg .. "/out/src/chromeDebugAdapter.js", "${port}" },
  },
}
