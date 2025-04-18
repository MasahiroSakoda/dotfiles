-- -*-mode:lua-*- vim:ft=lua
---@diagnostic disable: unused-local
local ls = require("luasnip")
local s  = ls.snippet
local t  = ls.text_node
local as = ls.extend_decorator.apply(s, { snippetType = "autosnippet" })

local cond = require("snippets.tex.util.conditions")

local snippets = {
  -- Numbers
  as({ trig = "NN",  dscr = "Natural numbers" },    t("\\mathbb{N}"), { condition = cond.in_math }),
  as({ trig = "QQ",  dscr = "Relational numbers" }, t("\\mathbb{Q}"), { condition = cond.in_math }),
  as({ trig = "RR",  dscr = "Real numbers" },       t("\\mathbb{R}"), { condition = cond.in_math }),
  as({ trig = "CC",  dscr = "Complex numbers" },    t("\\mathbb{C}"), { condition = cond.in_math }),
  as({ trig = "II",  dscr = "Integer numbers" },    t("\\mathbb{I}"), { condition = cond.in_math }),

  -- Sets
  as({ trig = "00",  dscr = "Empty sets" }, t("\\emptyset"), { condition = cond.in_math }),
  as({ trig = "EE",  dscr = "Exists" },     t("\\exists"),   { condition = cond.in_math }),
  as({ trig = "00",  dscr = "For all" },    t("\\forall"),   { condition = cond.in_math }),

  as({ trig = "sub",  dscr = "Subset" },           t("\\subset"),      { condition = cond.in_math }),
  as({ trig = "sub=", dscr = "Subset equals to" }, t("\\subseteq"),    { condition = cond.in_math }),
  as({ trig = "sub!", dscr = "Subset equals to" }, t("\\not\\subset"), { condition = cond.in_math }),
  as({ trig = "sup",  dscr = "Superset" },         t("\\supset"),      { condition = cond.in_math }),
  as({ trig = "sup=", dscr = "Superset" },         t("\\supseteq"),    { condition = cond.in_math }),
  as({ trig = "sup!", dscr = "Superset" },         t("\\not\\supset"), { condition = cond.in_math }),

  as({ trig = "!=",  dscr = "Not equal to" },  t("\\neq"),   { condition = cond.in_math }),
  as({ trig = "eqv", dscr = "Equivalent to" }, t("\\equiv"), { condition = cond.in_math }),
  as({ trig = "::",  dscr = "Colon" },         t("\\colon"), { condition = cond.in_math }),

  as({ trig = "<=",  dscr = "Less than equal to" },    t("\\leq"), { condition = cond.in_math }),
  as({ trig = ">=",  dscr = "greater than equal to" }, t("\\geq"), { condition = cond.in_math }),

  as({ trig = "~-",  dscr = "Approximation" }, t("\\simeq"), { condition = cond.in_math }),
  as({ trig = "~=",  dscr = "Congruent" },     t("\\cong"),  { condition = cond.in_math }),

  -- Dots
  as({ trig = "..",  dscr = "Dots" },          t("\\dots"),  { condition = cond.in_math }),
  as({ trig = "c.",  dscr = "Centered dots" }, t("\\cdots"), { condition = cond.in_math }),
  as({ trig = "l.",  dscr = "Lower dots" },    t("\\ldots"), { condition = cond.in_math }),
  as({ trig = "v.",  dscr = "Vertical dots" }, t("\\vdots"), { condition = cond.in_math }),
  as({ trig = "d.",  dscr = "Diagonal dots" }, t("\\ddots"), { condition = cond.in_math }),
}
return snippets
