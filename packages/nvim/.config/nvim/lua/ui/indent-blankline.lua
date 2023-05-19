local ok, ib =  pcall(require, "indent_blankline")
if not ok then return end

local cmd = vim.cmd

-- With custom background highlight
-- cmd[[highlight IndentBlanklineIndent1 guibg=#1f1f1f gui=nocombine]]
-- cmd[[highlight IndentBlanklineIndent2 guibg=#1a1a1a gui=nocombine]]

-- With custom g:indent_blankline_char_highlight_list
cmd [[highlight IndentBlanklineIndent1 guifg=#E06C75 gui=nocombine]]
cmd [[highlight IndentBlanklineIndent2 guifg=#E5C07B gui=nocombine]]
cmd [[highlight IndentBlanklineIndent3 guifg=#98C379 gui=nocombine]]
cmd [[highlight IndentBlanklineIndent4 guifg=#56B6C2 gui=nocombine]]
cmd [[highlight IndentBlanklineIndent5 guifg=#61AFEF gui=nocombine]]
cmd [[highlight IndentBlanklineIndent6 guifg=#C678DD gui=nocombine]]


ib.setup({
  char = "┊",
  buftype_exclude  = { "terminal", "nofile" },
  filetype_exclude = { "help", "lazy", "alpha", "neo-tree", "Trouble" },
  --[[ With custom background highlight
  char = "",
  char_highlight_list = {
    "IndentBlanklineIndent1",
    "IndentBlanklineIndent2",
  },
  space_char_highlight_list = {
    "IndentBlanklineIndent1",
    "IndentBlanklineIndent2",
  },
  show_trailing_blankline_indent = false,
  ]]

  char_highlight_list = {
    "IndentBlanklineIndent1",
    "IndentBlanklineIndent2",
    "IndentBlanklineIndent3",
    "IndentBlanklineIndent4",
    "IndentBlanklineIndent5",
    "IndentBlanklineIndent6",
  },

  -- With context indent highlighted by treesitter
  space_char_blankline       = " ",
  show_current_context       = true,
  show_current_context_start = true,

})
