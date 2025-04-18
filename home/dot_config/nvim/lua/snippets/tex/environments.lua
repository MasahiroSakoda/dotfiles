-- -*-mode:lua-*- vim:ft=lua
---@diagnostic disable: unused-local
local ls = require("luasnip")
local s  = ls.snippet
local t  = ls.text_node
local i  = ls.insert_node
local c  = ls.choice_node
local d  = ls.dynamic_node
-- local r  = ls.restore_node
-- local f  = ls.function_node
-- local sn = ls.snippet_node
local as = ls.extend_decorator.apply(s, { snippetType = "autosnippet" })
local extras = require("luasnip.extras")
local rep    = extras.rep
-- local m      = extras.m
-- local l      = extras.l
-- local fmt     = require("luasnip.extras.fmt").fmt
local fmta    = require("luasnip.extras.fmt").fmta
-- local postfix = require("luasnip.extras.postfix").postfix
-- local conds   = require("luasnip.extras.conditions")
local condse  = require("luasnip.extras.conditions.expand")
local cond    = require("snippets.tex.util.conditions")
local util    = require("utils.snippet")

local snippets = {
  s({ trig = ":env", dscr = "Generic Environment" },
    fmta('\\begin{<>}\n<>\n\\end{<>}', { i(1, "environment"), d(2, util.get_visual), rep(1) }),
    { condition = condse.line_begin and not cond.in_math }
  ),
  s({ trig = ":ENV", dscr = "tex template" },
    fmta('\\begin{<>}\n<>\n\\end{<>}', { c(1, { t("align*"), t("equation*"), t("equation*") }), i(0), rep(1) }),
    { condition = condse.line_begin and not cond.in_math }
  ),

  as({ trig = ":item", dscr = "Itemize" },
    fmta('\\begin{itemize}\n\\item <>\n\\end{itemize}', { i(0) }),
    { condition = condse.line_begin and not cond.in_math }
  ),
  as({ trig = ":enum", dscr = "Enummerate" },
    fmta('\\begin{enumerate}\n\\item <>\n\\end{enumerate}', { i(0) }),
    { condition = condse.line_begin and not cond.in_math }
  ),

  as({ trig = ":chap", dscr = "LaTex chapter" },
    fmta([[\chapter{<>}<>]], { i(1, "Title"), i(0) }),
    { condition = condse.line_begin }
  ),

  as({ trig = ":sect", dscr = "LaTex section" },
    fmta([[\<>section{<>}<>]], { c(1, { t(""), t("sub"), t("subsub") }), i(2, "Title"), i(0) }),
    { condition = condse.line_begin and not cond.in_math }
  ),

}
return snippets
