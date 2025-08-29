-- -*-mode:lua-*- vim:ft=lua

vim.g.tex_flavor             = "latex"
vim.g.vimtex_compiler_method = "latexmk"
vim.g.vimtex_quickfix_mode   = 0 -- Disable auto popup of quickfix window
-- vim.g.vimtex_fold_enabled    = true
vim.g.vimtex_syntax_conceal = {
  accents         = true,
  ligatures       = true,
  cites           = true,
  fancy           = true,
  spacing         = false, -- default: true
  greek           = true,
  math_bounds     = true,
  math_delimiters = true,
  math_fracs      = true,
  math_super_sub  = true,
  math_symbols    = true,
}

local uname = vim.uv.os_uname().sysname
if uname == "Darwin" then
  vim.g.vimtex_view_method          = "general"
  vim.g.vimtex_view_general_viewer  = "open"
  vim.g.vimtex_view_general_options = "-a Preview @pdf"
elseif uname == "Linux" then
  vim.g.vimtex_view_method         = "zathura"
  vim.g.vimtex_view_general_viewer = "zathura"
end
