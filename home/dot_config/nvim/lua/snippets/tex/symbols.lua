-- -*-mode:lua-*- vim:ft=lua
---@diagnostic disable: unused-local
local ls = require("luasnip")
local s  = ls.snippet
local t  = ls.text_node

local cond = require("snippets.tex.util.conditions")

local snippets = {
  -- Numbers
  s({ trig = "NN", name = "Natural numbers", dscr = "Natural numbers", snippetType = "autosnippet" },
    t("\\mathbb{N}"),
    { condition = cond.in_math }
  ),
  s({ trig = "QQ", name = "Relational numbers", dscr = "Relational numbers", snippetType = "autosnippet" },
    t("\\mathbb{Q}"),
    { condition = cond.in_math }
  ),
  s({ trig = "RR", name = "Real numbers", dscr = "Real numbers", snippetType = "autosnippet" },
    t("\\mathbb{R}"),
    { condition = cond.in_math }
  ),
  s({ trig = "CC", name = "Complex numbers", dscr = "Complex numbers", snippetType = "autosnippet" },
    t("\\mathbb{C}"),
    { condition = cond.in_math }
  ),
  s({ trig = "II", name = "Integer numbers", dscr = "Integer numbers", snippetType = "autosnippet" },
    t("\\mathbb{I}"),
    { condition = cond.in_math }
  ),

  -- Sets
  s({ trig = "00", name = "Empty sets", dscr = "Empty sets", snippetType = "autosnippet" },
    t("\\emptyset"),
    { condition = cond.in_math }
  ),
  s({ trig = "EE", name = "Exists", dscr = "Exists", snippetType = "autosnippet" },
    t("\\exists"),
    { condition = cond.in_math }
  ),
  s({ trig = "00", name = "For all", dscr = "For all", snippetType = "autosnippet" },
    t("\\forall"),
    { condition = cond.in_math }
  ),

  s({ trig = "sub", name = "Subset", dscr = "Subset", snippetType = "autosnippet" },
    t("\\subset"),
    { condition = cond.in_math }
  ),
  s({ trig = "sub=", name = "Subset equals to", dscr = "Subset equals to", snippetType = "autosnippet" },
    t("\\subseteq"),
    { condition = cond.in_math }
  ),
  s({ trig = "sub!", name = "Subset equals to", dscr = "Subset equals to", snippetType = "autosnippet" },
    t("\\not\\subset"),
    { condition = cond.in_math }
  ),
  s({ trig = "sup", name = "Superset", dscr = "Superset", snippetType = "autosnippet" },
    t("\\supset"),
    { condition = cond.in_math }
  ),
  s({ trig = "sup=", name = "Superset", dscr = "Superset", snippetType = "autosnippet" },
    t("\\supseteq"),
    { condition = cond.in_math }
  ),
  s({ trig = "sup!", name = "Superset", dscr = "Superset", snippetType = "autosnippet" },
    t("\\not\\supset"),
    { condition = cond.in_math }
  ),

  s({ trig = "!=", name = "Not equal to", dscr = "Not equal to", snippetType = "autosnippet" },
    t("\\neq"), { condition = cond.in_math }
  ),
  s({ trig = "eqv", name = "Equivalent to", dscr = "Equivalent to", snippetType = "autosnippet" },
    t("\\equiv"),
    { condition = cond.in_math }
  ),
  s({ trig = "::", name = "Colon", dscr = "Colon", snippetType = "autosnippet" },
    t("\\colon"),
    { condition = cond.in_math }
  ),

  s({ trig = "<=", name = "<=", dscr = "Less than equal to", snippetType = "autosnippet" },
    t("\\leq"),
    { condition = cond.in_math }
  ),
  s({ trig = ">=", name = ">=", dscr = "greater than equal to", snippetType = "autosnippet" },
    t("\\geq"),
    { condition = cond.in_math }
  ),

  s({ trig = "~-", name = "Approximation", dscr = "Approximation", snippetType = "autosnippet" },
    t("\\simeq"),
    { condition = cond.in_math }
  ),
  s({ trig = "~=", name = "Congruent", dscr = "Congruent", snippetType = "autosnippet" },
    t("\\cong"),
    { condition = cond.in_math }
  ),

  -- Dots
  s({ trig = "..", name = "Dots", dscr = "Dots", snippetType = "autosnippet" },
    t("\\dots"),
    { condition = cond.in_math }
  ),
  s({ trig = "c.", name = "Centered dots", dscr = "Centered dots", snippetType = "autosnippet" },
    t("\\cdots"),
    { condition = cond.in_math }
  ),
  s({ trig = "l.", name = "Lower dots", dscr = "Lower dots", snippetType = "autosnippet" },
    t("\\ldots"),
    { condition = cond.in_math }
  ),
  s({ trig = "v.", name = "Vertical dots", dscr = "Vertical dots", snippetType = "autosnippet" },
    t("\\vdots"),
    { condition = cond.in_math }
  ),
  s({ trig = "d.", name = "Diagonal dots", dscr = "Diagonal dots", snippetType = "autosnippet" },
    t("\\ddots"),
    { condition = cond.in_math }
  ),
}
return snippets
