-- -*-mode:lua-*- vim:ft=lua

local M = {}

---@param package string Install path for package
M.install_path = function(package)
  return require("mason-registry").get_package(package):get_install_path()
end

return M
