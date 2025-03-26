-- -*-mode:lua-*- vim:ft=lua
local package = "js-debug-adapter"

return {
  type = "server",
  host = "localhost",
  port = "${port}",
  executable = {
    command = "node",
    args    = { vim.fn.stdpath("data") .. "/mason/bin/" .. package, "${port}"},
  },
}
