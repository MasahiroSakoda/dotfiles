-- -*-mode:lua-*- vim:ft=lua
local ls = require("luasnip")
---@diagnostic disable-next-line: unused-local
local s, t, i, c, r, f, sn =
  ls.snippet,ls.text_node, ls.insert_node, ls.choice_node, ls.restore_node, ls.function_node, ls.snippet_node
---@diagnostic disable-next-line: unused-local
local fmt, fmta = require("luasnip.extras.fmt").fmt, require("luasnip.extras.fmt").fmta
---@diagnostic disable-next-line: unused-local
local conds, condse = require("luasnip.extras.conditions"), require("luasnip.extras.conditions.expand")
---@diagnostic disable-next-line: unused-local
local rep = require("luasnip.extras").rep

local snippets = {
  s("exp",  fmt('export {}={}', { i(1, "variable"), i(2, "value") })),
  s("loc",  fmt('local {}={}',  { i(1, "variable"), i(2, "value") })),

  s("func", fmt('function {}({}) {{\n\t{}\n}}', { i(1, "name"), i(2, "parameter"), i(3, "code") })),
  s("for",  fmt('for {} in {} do\n\t{}\ndone',  { i(1, "item"), i(2, "list"), i(3, "code") })),

  s("if",   fmt('if {} ; then\n\t{}\nfi', { i(1, "condition"), i(2, "code") }))

}
return snippets
