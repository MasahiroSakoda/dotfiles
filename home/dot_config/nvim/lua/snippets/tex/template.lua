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
local condse  = require("luasnip.extras.conditions.expand")
local cond    = require("snippets.tex.util.conditions")

local snippets = {
  s({ trig = "tex", name = "tex template", dscr = "tex template" },
    fmta([[
    \documentclass[<>,<>]{<>}
    \usepackage{amsmath}

    \title{<>}
    \author{<>}
    \date{\today}

    \begin{document}
    <>
    \end{document}
    ]], { i(1, "size"), i(2, "font size"), i(3, "style"), i(3, "title"), i(4, "author"), i(0) }),
    { condition = condse.line_begin and not cond.in_math }
  ),

}
return snippets
