-- -*-mode:lua-*- vim:ft=lua

local M = {}

local function get_file_extension(filename)
  local match = filename:match("^.+(%..+)$")
  return match ~= nil and match:sub(2)
end

function M.file_icon(filename, default)
  local has_devicons, devicons = pcall(require, "nvim-web-devicons")
  if not has_devicons then
    vim.notify("Failed to load nvim-web-devicons", vim.log.levels.WARN)
  end

  local extension = get_file_extension(filename)
  return devicons.get_icon(filename, extension, { default = default })
end

return M
