-- -*-mode:lua-*- vim:ft=lua
local package = "debugpy"

return {
  type    = "executable";
  command = vim.fn.stdpath("data") .. "/mason/bin/" .. package,
  args    = { "-m", "debugpy.adapter" },
}
