-- -*-mode:lua-*- vim:ft=lua

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern  = { "*.log" },
  group    = vim.api.nvim_create_augroup("CustomLogGroup", { clear = true }),
  callback = function()
    vim.bo.filetype = "log"
  end,
})
