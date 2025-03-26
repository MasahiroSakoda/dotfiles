-- -*-mode:lua-*- vim:ft=lua
local mason = require("mason-registry")
local pkg = "debugpy"

return {
  type    = "executable";
  -- command = vim.fn.stdpath("data") .. "/mason/bin/" .. pkg,
  command = mason.get_package(pkg):get_install_path() .. "/venv/bin/python3",
  args    = { "-m", "debugpy.adapter" },
  options = { source_filetype = "python" },
}
