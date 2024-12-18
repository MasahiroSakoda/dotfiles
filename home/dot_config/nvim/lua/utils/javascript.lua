-- -*-mode:lua-*- vim:ft=lua

local M = {}
local filetypes = require("user.filetypes")

local file_in_project = function(files)
  for _, file in ipairs(files) do
    if vim.fn.filereadable(file) then
      return true
    end
  end
  return false
end

M.project_root      = function() return vim.fs.root(0, "package.json") or vim.fn.getcwd() end
M.is_jest_available = function() return vim.fn.filereadable("./node_modules/jest/bin/jest.js") end
M.is_next_project   = function() return file_in_project(filetypes.lsp.next) end
M.is_deno_project   = function() return file_in_project(filetypes.lsp.deno) end

return M
