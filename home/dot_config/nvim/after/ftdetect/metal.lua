-- -*-mode:lua-*- vim:ft=lua
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile"}, {
  desc     = "Detect filetype for Metal Shading Language",
  pattern  = "*.metal",
  callback = function() vim.bo.filetype = "cpp" end,
})
