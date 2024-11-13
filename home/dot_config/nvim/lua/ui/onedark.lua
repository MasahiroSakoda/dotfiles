-- -*-mode:lua-*- vim:ft=lua

local onedark_ok, onedark = pcall(require, "onedark")
if not onedark_ok then return end

onedark.setup({
  style = "darker", ---@type "dark"|"darker"|"cool"|"deep"|"warm"|"warmer"
  transparent = true,

  toggle_style_key = ",C",

  code_style = {
    comments  = "italic",
    keywords  = "bold",
    functions = "italic",
    types     = "italic,bold",
  },
})
