local M = {}

M.file_exists = function (file)
  local f = io.open(file, "rb")
  if f then f:close() end
  return f ~= nil
end

---@param path string
---@return string
M.shorten_path = function(path)
  ---@diagnostic disable-next-line: redundant-return-value
  return path
      -- Remove CWD
    ---@diagnostic disable-next-line: undefined-field
    :gsub(vim.pesc(vim.loop.cwd()) .. "/", "")
    -- Remove home dir
    :gsub(vim.pesc(vim.fn.expand "$HOME"), "~")
    -- Remove trailing slash
    :gsub("/$", "")
end

return M
