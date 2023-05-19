local g = vim.g
vim.cmd([[
  hi Floaterm guibg=#343746
  hi FloatermBorder guifg=##a3ff00 guibg=#5c00ff
  hi FloatermNC guifg=gray
]])
g.floaterm_autoclose = 1
g.floaterm_position = "center"
g.floaterm_width    = 0.75
g.floaterm_height   = 0.75
g.floaterm_wintitle = 0
g.floaterm_borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" }
