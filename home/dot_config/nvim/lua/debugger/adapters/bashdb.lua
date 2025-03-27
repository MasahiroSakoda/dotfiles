-- -*-mode:lua-*- vim:ft=lua
local package = "bash-debug-adapter"

return {
  {
    type    = "executable",
    port    = "${port}",
    command = vim.fn.stdpath("data") .. "/mason/bin/" .. package,
  }
}
