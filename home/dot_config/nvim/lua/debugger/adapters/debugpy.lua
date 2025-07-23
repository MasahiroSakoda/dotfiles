-- -*-mode:lua-*- vim:ft=lua
local pkg = "debugpy"

return {
  type    = "executable";
  command = vim.fn.stdpath("data") .. "/mason/bin/" .. pkg,
  args    = { "-m", "debugpy.adapter" },
  options = { source_filetype = "python" },
}
