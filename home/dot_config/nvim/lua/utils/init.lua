local M = {}

M.file_exists = function (file)
  local f = io.open(file, "rb")
  if f then f:close() end
  return f ~= nil
end

M.open_cfile = function(opts)
  opts = opts or {}
  local cfile = vim.fn.expand("<cfile>")
  -- Open File or URL
  if cfile:match("^https?://") then
    if vim.fn.has("mac") then
      vim.fn.system({"open", cfile})
    elseif vim.fn.executable("xdg-open") then
      vim.fn.system({"xdg-open", cfile})
    end
    -- INFO `vim.ui.open()` usable NeoVim nightly environment for now
    -- vim.ui.open(cfile)
  else
    vim.cmd([[normal! gF]])
  end
end

return M
