-- -*-mode:lua-*- vim:ft=lua
---@diagnostic disable: unused-local
local ls = require("luasnip")
local s  = ls.snippet
local t  = ls.text_node
-- local i  = ls.insert_node
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
-- local fmta    = require("luasnip.extras.fmt").fmta
-- local postfix = require("luasnip.extras.postfix").postfix
-- local conds   = require("luasnip.extras.conditions")
-- local condse  = require("luasnip.extras.conditions.expand")

local util = require("utils.luasnip")

local snippets = {
  -- Numbers
  s({ trig = "NN", name = "Natural numbers", dscr = "Natural numbers", snippetType = "autosnippet" },
    t("\\mathbb{N}"),
    { condition = util.in_math }
  ),
  s({ trig = "QQ", name = "Relational numbers", dscr = "Relational numbers", snippetType = "autosnippet" },
    t("\\mathbb{Q}"),
    { condition = util.in_math }
  ),
  s({ trig = "RR", name = "Real numbers", dscr = "Real numbers", snippetType = "autosnippet" },
    t("\\mathbb{R}"),
    { condition = util.in_math }
  ),
  s({ trig = "CC", name = "Complex numbers", dscr = "Complex numbers", snippetType = "autosnippet" },
    t("\\mathbb{C}"),
    { condition = util.in_math }
  ),
  s({ trig = "II", name = "Integer numbers", dscr = "Integer numbers", snippetType = "autosnippet" },
    t("\\mathbb{I}"),
    { condition = util.in_math }
  ),

  -- Sets
  s({ trig = "00", name = "Empty sets", dscr = "Empty sets", snippetType = "autosnippet" },
    t("\\emptyset"),
    { condition = util.in_math }
  ),
  s({ trig = "EE", name = "Exists", dscr = "Exists", snippetType = "autosnippet" },
    t("\\exists"),
    { condition = util.in_math }
  ),
  s({ trig = "00", name = "For all", dscr = "For all", snippetType = "autosnippet" },
    t("\\forall"),
    { condition = util.in_math }
  ),

  s({ trig = "sub", name = "Subset", dscr = "Subset", snippetType = "autosnippet" },
    t("\\subset"),
    { condition = util.in_math }
  ),
  s({ trig = "sub=", name = "Subset equals to", dscr = "Subset equals to", snippetType = "autosnippet" },
    t("\\subseteq"),
    { condition = util.in_math }
  ),
  s({ trig = "sub!", name = "Subset equals to", dscr = "Subset equals to", snippetType = "autosnippet" },
    t("\\not\\subset"),
    { condition = util.in_math }
  ),
  s({ trig = "sup", name = "Superset", dscr = "Superset", snippetType = "autosnippet" },
    t("\\supset"),
    { condition = util.in_math }
  ),
  s({ trig = "sup=", name = "Superset", dscr = "Superset", snippetType = "autosnippet" },
    t("\\supseteq"),
    { condition = util.in_math }
  ),
  s({ trig = "sup!", name = "Superset", dscr = "Superset", snippetType = "autosnippet" },
    t("\\not\\supset"),
    { condition = util.in_math }
  ),

  s({ trig = "!=", name = "Not equal to", dscr = "Not equal to", snippetType = "autosnippet" },
    t("\\neq"), { condition = util.in_math }
  ),
  s({ trig = "eqv", name = "Equivalent to", dscr = "Equivalent to", snippetType = "autosnippet" },
    t("\\equiv"),
    { condition = util.in_math }
  ),
  s({ trig = "::", name = "Colon", dscr = "Colon", snippetType = "autosnippet" },
    t("\\colon"),
    { condition = util.in_math }
  ),

  s({ trig = "<=", name = "<=", dscr = "Less than equal to", snippetType = "autosnippet" },
    t("\\leq"),
    { condition = util.in_math }
  ),
  s({ trig = ">=", name = ">=", dscr = "greater than equal to", snippetType = "autosnippet" },
    t("\\geq"),
    { condition = util.in_math }
  ),

  s({ trig = "~-", name = "Approximation", dscr = "Approximation", snippetType = "autosnippet" },
    t("\\simeq"),
    { condition = util.in_math }
  ),
  s({ trig = "~=", name = "Congruent", dscr = "Congruent", snippetType = "autosnippet" },
    t("\\cong"),
    { condition = util.in_math }
  ),

  -- Dots
  s({ trig = "..", name = "Dots", dscr = "Dots", snippetType = "autosnippet" },
    t("\\dots"),
    { condition = util.in_math }
  ),
  s({ trig = "c.", name = "Centered dots", dscr = "Centered dots", snippetType = "autosnippet" },
    t("\\cdots"),
    { condition = util.in_math }
  ),
  s({ trig = "l.", name = "Lower dots", dscr = "Lower dots", snippetType = "autosnippet" },
    t("\\ldots"),
    { condition = util.in_math }
  ),
  s({ trig = "v.", name = "Vertical dots", dscr = "Vertical dots", snippetType = "autosnippet" },
    t("\\vdots"),
    { condition = util.in_math }
  ),
  s({ trig = "d.", name = "Diagonal dots", dscr = "Diagonal dots", snippetType = "autosnippet" },
    t("\\ddots"),
    { condition = util.in_math }
  ),
}
return snippets
