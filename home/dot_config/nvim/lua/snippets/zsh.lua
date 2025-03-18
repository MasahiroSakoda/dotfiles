-- -*-mode:lua-*- vim:ft=lua
local ls = require("luasnip")
local s, i = ls.snippet,ls.text_node
local fmt = require("luasnip.extras.fmt").fmt

local snippets = {
  s("exp",  fmt('export {}={}\n{}', { i(1, "variable"), i(2, "value"), i(0) })),
  s("loc",  fmt('local {}={}\n{}',  { i(1, "variable"), i(2, "value"), i(0) })),

  s("func", fmt('function {}({}) {{\n\t{}\n}}\n{}', { i(1, "name"), i(2, "parameter"), i(3, "code"), i(0) })),
  s("for",  fmt('for {} in {} do\n\t{}\ndone\n{}',  { i(1, "item"), i(2, "list"), i(3, "code"), i(0) })),

  s("if",   fmt('if {} ; then\n\t{}\nfi\n{}', { i(1, "condition"), i(2, "code"), i(0) }))

}
return snippets
