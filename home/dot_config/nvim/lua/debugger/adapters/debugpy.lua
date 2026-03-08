-- -*-mode:lua-*- vim:ft=lua

return {
  type    = "executable";
  command = "debugpy",
  args    = { "-m", "debugpy.adapter" },
  options = { source_filetype = "python" },
}
