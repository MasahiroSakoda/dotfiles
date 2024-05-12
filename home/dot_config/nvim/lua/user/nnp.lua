-- -*-mode:lua-*- vim:ft=lua

local ok, nnp = pcall(require, "no-neck-pain")
if not ok then return end

-- https://github.com/shortcuts/no-neck-pain.nvim#-configuration
nnp.setup({
  debug = false,
  width = 130,

  autocmds = {
    enableOnVimEnter = true,
    enableOnTabEnter = true,
  },
})
