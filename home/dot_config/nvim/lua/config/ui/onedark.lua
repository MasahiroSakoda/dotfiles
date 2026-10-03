require("onedark").setup({
  style = vim.g.themestyle,
  transparent = true,
  toggle_style_key = "<NOP>",

  code_style = {
    comments  = "italic",
    keywords  = "bold",
    functions = "italic",
    types     = "italic,bold",
  },
})
