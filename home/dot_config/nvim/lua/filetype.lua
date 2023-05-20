vim.filetype.add {
  extension = {
    applescript = "applescript",
    jbuilder = "ruby",
    plist = "xml",
    ttx = "xml",
    help = function()
      vim.api.nvim_buf_set_keymap(0, 'n', 'q', 'ZZ', { noremap = true })
      -- vim.cmd[[autocmd! BufEnter * if &ft ==# 'help' | wincmd L | endif]]
      vim.cmd[[autocmd BufEnter *.txt if &buftype == 'help' | wincmd L | endif]]
    end
  }
}
