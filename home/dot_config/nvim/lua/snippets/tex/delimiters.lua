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
local extras = require("luasnip.extras")
local rep    = extras.rep
-- local m      = extras.m
-- local l      = extras.l
-- local fmt     = require("luasnip.extras.fmt").fmt
local fmta    = require("luasnip.extras.fmt").fmta
-- local postfix = require("luasnip.extras.postfix").postfix
-- local conds   = require("luasnip.extras.conditions")
-- local condse  = require("luasnip.extras.conditions.expand")

local util = require("utils.luasnip")

local snippets = {
  s({ trig = "im", name = "Inline math", dscr = "Inline math", snippetType = "autosnippet" },
    fmta([[$<>$]], { i(0) }),
    { condition = not util.in_math }
  ),
  s({ trig = "mbs", name = "Block math", dscr = "Block math (single line)", snippetType = "autosnippet" },
    fmta([[$$<>$$]], { i(0) }),
    { condition = not util.in_math }
  ),
  s({ trig = "mbm", name = "Block math", dscr = "Block math (multiline)", snippetType = "autosnippet" },
    fmta([[
    $$
    <>
    $$]], { i(0) }),
    { condition = not util.in_math }
  ),

  s({ trig = "math", name = "Math environment", dscr = "Math environment", snippetType = "autosnippet" },
    fmta([[
    \begin{<>}
    <>
    \end{<>}
    ]], {
      c(1, { t("math"), t("displaymath") }),
      i(0, "formula"),
      rep(1)
    }),
    { condition = not util.in_math }
  ),
}
return snippets
