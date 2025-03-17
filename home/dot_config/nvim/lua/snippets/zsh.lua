-- -*-mode:lua-*- vim:ft=lua
local ls = require("luasnip")
local s, i = ls.snippet,ls.text_node
local fmt = require("luasnip.extras.fmt").fmt

local snippets = {
  s("exp",  fmt('export {}={}', { i(1, "variable"), i(2, "value") })),
  s("loc",  fmt('local {}={}',  { i(1, "variable"), i(2, "value") })),

  s("func", fmt('function {}({}) {{\n\t{}\n}}', { i(1, "name"), i(2, "parameter"), i(3, "code") })),
  s("for",  fmt('for {} in {} do\n\t{}\ndone',  { i(1, "item"), i(2, "list"), i(3, "code") })),

  s("if",   fmt('if {} ; then\n\t{}\nfi', { i(1, "condition"), i(2, "code") }))

}
return snippets
