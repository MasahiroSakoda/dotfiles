-- -*-mode:lua-*- vim:ft=lua
---@diagnostic disable: unused-local
local ls = require("luasnip")
local s  = ls.snippet
-- local t  = ls.text_node
local i  = ls.insert_node
-- local c  = ls.choice_node
-- local d  = ls.dynamic_node
-- local r  = ls.restore_node
-- local f  = ls.function_node
-- local sn = ls.snippet_node
-- local extras = require("luasnip.extras")
-- local rep    = extras.rep
-- local m      = extras.m
-- local l      = extras.l
-- local fmt     = require("luasnip.extras.fmt").fmt
local fmta    = require("luasnip.extras.fmt").fmta
-- local postfix = require("luasnip.extras.postfix").postfix
-- local conds   = require("luasnip.extras.conditions")
-- local condse  = require("luasnip.extras.conditions.expand")

local snippets = {
  s("exp",  fmta('export <>=<>\n<>', { i(1, "var"), i(2, "value"), i(0) })),
  s("loc",  fmta('local <>=<>\n<>',  { i(1, "var"), i(2, "value"), i(0) })),

  s("func", fmta('function <>(<>) {\n\t<>\n}',   { i(1, "name"), i(2, "param"), i(0) })),
  s("for",  fmta('for <> in <> do\n\t<>\ndone',  { i(1, "item"), i(2, "list"), i(0) })),

  s("if",   fmta('if <> ; then\n\t<>\nfi', { i(1, "condition"), i(0) }))

}
return snippets
