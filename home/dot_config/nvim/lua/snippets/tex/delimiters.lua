-- -*-mode:lua-*- vim:ft=lua
---@diagnostic disable: unused-local
local ls = require("luasnip")
local s  = ls.snippet
local t  = ls.text_node
local i  = ls.insert_node
local c  = ls.choice_node
-- local d  = ls.dynamic_node
-- local r  = ls.restore_node
-- local f  = ls.function_node
-- local sn = ls.snippet_node
local as = ls.extend_decorator.apply(s, { snippetType = "autosnippet" })
local extras = require("luasnip.extras")
local rep    = extras.rep
-- local m      = extras.m
-- local l      = extras.l
local fmt     = require("luasnip.extras.fmt").fmt
local fmta    = require("luasnip.extras.fmt").fmta
-- local postfix = require("luasnip.extras.postfix").postfix
-- local conds   = require("luasnip.extras.conditions")
-- local condse  = require("luasnip.extras.conditions.expand")

local cond = require("snippets.tex.util.conditions")

local snippets = {
  as({ trig = "im",   dscr = "Inline math" },         fmta([[$<>$]],    { i(0) }), { condition = not cond.in_math }),
  as({ trig = "mbs",  dscr = "Block math (single)" }, fmt('$${}$$',     { i(0) }), { condition = not cond.in_math }),
  as({ trig = "mbm",  dscr = "Block math (multi)" },  fmt('$$\n{}\n$$', { i(0) }), { condition = not cond.in_math }),
  as({ trig = "math", dscr = "Math environment" },
    fmta('\\begin{<>}\n<>\n\\end{<>}', { c(1, { t("math"), t("displaymath") }), i(0), rep(1) }),
    { condition = not cond.in_math }
  ),
}
return snippets
