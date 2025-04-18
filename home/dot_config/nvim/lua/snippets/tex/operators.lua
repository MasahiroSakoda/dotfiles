-- -*-mode:lua-*- vim:ft=lua
---@diagnostic disable: unused-local
local ls = require("luasnip")
local s  = ls.snippet
local t  = ls.text_node
local i  = ls.insert_node
local c  = ls.choice_node
-- local d  = ls.dynamic_node
local r  = ls.restore_node
local f  = ls.function_node
local sn = ls.snippet_node
local as = ls.extend_decorator.apply(s, { snippetType = "autosnippet" })
local extras = require("luasnip.extras")
local rep    = extras.rep
-- local m      = extras.m
-- local l      = extras.l
-- local fmt     = require("luasnip.extras.fmt").fmt
local fmta    = require("luasnip.extras.fmt").fmta
-- local postfix = require("luasnip.extras.postfix").postfix
-- local conds   = require("luasnip.extras.conditions")
-- local condse  = require("luasnip.extras.conditions.expand")
local cond    = require("snippets.tex.util.conditions")

local snippets = {
  -- Fraction
  as({ trig = "([^%a])-f", dscr = "Fraction", wordTrig = false, regTrig = true },
    fmta([[\frac{<>}{<>}<>]], { i(1, "top"), i(2, "bottom"), i(0) }),
    { condition = cond.in_math }
  ),
  as({ trig = "([^%a])-d", dscr = "d Fraction", wordTrig = false, regTrig = true },
    fmta([[\dfrac{<>}{<>}<>]], { i(1, "top"), i(2, "bottom"), i(0) }),
    { condition = cond.in_math }
  ),
  as({ trig = "([^%a])-t", dscr = "text Fraction", wordTrig = false, regTrig = true },
    fmta([[\tfrac{<>}{<>}<>]], { i(1, "top"), i(2, "bottom"), i(0) }),
    { condition = cond.in_math }
  ),

  as({ trig = "([%a%)%]%}])^", dscr = "Involve" },
    fmta([[<>^{<>}]], { f(function(_, snip) return snip.captures[1] end), i(0) }),
    { condition = cond.in_math }
  ),

  -- Roots
  as({ trig = "sqr", dscr = "Square root" }, fmta([[\sqrt{<>}<>]],    { i(1), i(0) }), { condition = cond.in_math }),
  as({ trig = "cbr", dscr = "Cube root"   }, fmta([[\sqrt[3]{<>}<>]], { i(1), i(0) }), { condition = cond.in_math }),

  -- Limit
  as({ trig = "lim", name = "lim(sup|inf)", dscr = "lim(sup|inf)" },
    fmta([[\lim<><><>]], {
      c(1, { t(""), t("sup"), t("inf") }),
      c(2, { sn(1, { t("_{"), r(1, "param"), t(" \\to "), r(2, "to"), t("}") }), sn(1, { t("") }) }),
      i(0, "formula")
    }),
    { condition = cond.in_math }
  ),

  -- Sum
  as({ trig = "sum", name = "Sum", dscr = "Sum" },
    fmta([[\sum<> <>]], {
      c(1, { sn(1, { t("_{"), r(1, "bottom"), t("}^{"), r(2, "top"), t("}") }), sn(1, { t("") }) }),
      i(0, "formula")
    }),
    { condition = cond.in_math }
  ),

  -- Multiply
  as({ trig = "prod", name = "Product", dscr = "Product" },
    fmta([[\prod<> <>]], {
      c(1, { sn(1, { t("_{"), r(1, "bottom"), t("}^{"), r(2, "top"), t("}") }), sn(1, { t("") }) }),
      i(0, "formula"),
    }),
    { condition = cond.in_math }
  ),

  -- Integral
  as({ trig = "integ", name = "Integral", dscr = "Integral" },
    fmta([[\<><> <> \, d<>]], {
      c(1, { t("int"), t("iint"), t("iiint"), t("idotsint") }),
      c(2, { sn(1, { t("_{"), r(1, "bottom"), t("}^{"), r(2, "top"), t("}") }), sn(1, { t("") }) }),
      i(3, "formula"),
      i(4, "x")
    }),
    { condition = cond.in_math }
  ),

  -- Matrix
  as({ trig = "matrix", name = "Matrix", dscr = "Matrix" },
    fmta([[
    \begin{<>matrix}
    <>
    \end{<>matrix}
    ]], { c(1, { t(""), t("p"), t("b"), t("B"), t("v"), t("V"), t("small") }), i(0, "element"), rep(1) }),
    { condition = cond.in_math }
  ),
}
return snippets
