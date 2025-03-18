-- -*-mode:lua-*- vim:ft=lua
local ls = require("luasnip")
local s  = ls.snippet
-- local t  = ls.text_node
local i  = ls.insert_node
-- local c  = ls.choice_node
-- local r  = ls.restore_node
-- local f  = ls.function_node
-- local sn = ls.snippet_node
-- local extras = require("luasnip.extras")
-- local rep    = extras.rep
-- local m      = extras.m
-- local l      = extras.l
local fmt    = require("luasnip.extras.fmt").fmt
-- local fmta   = require("luasnip.extras.fmta")
-- local conds  = require("luasnip.extras.conditions")
-- local condse = require("luasnip.extras.conditions.expand")

local snippets = {
  s("exp",  fmt('export {}={}\n{}', { i(1, "variable"), i(2, "value"), i(0) })),
  s("loc",  fmt('local {}={}\n{}',  { i(1, "variable"), i(2, "value"), i(0) })),

  s("func", fmt('function {}({}) {{\n\t{}\n}}\n{}', { i(1, "name"), i(2, "parameter"), i(3, "code"), i(0) })),
  s("for",  fmt('for {} in {} do\n\t{}\ndone\n{}',  { i(1, "item"), i(2, "list"), i(3, "code"), i(0) })),

  s("if",   fmt('if {} ; then\n\t{}\nfi\n{}', { i(1, "condition"), i(2, "code"), i(0) }))

}
return snippets
