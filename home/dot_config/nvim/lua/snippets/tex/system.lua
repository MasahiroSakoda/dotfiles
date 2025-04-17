-- -*-mode:lua-*- vim:ft=lua
---@diagnostic disable: unused-local
local ls = require("luasnip")
local s  = ls.snippet
-- local t  = ls.text_node
local i  = ls.insert_node
-- local c  = ls.choice_node
local d  = ls.dynamic_node
-- local r  = ls.restore_node
local f  = ls.function_node
-- local sn = ls.snippet_node
local as = ls.extend_decorator.apply(s, { snippetType = "autosnippet" })
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
local util    = require("utils.luasnip")

local snippets = {
  as({ trig = ":pkg", dscr = "LaTeX package" },
    fmta([[\usepackage{<>}]], { d(1, util.get_visual) }),
    { condition = condse.line_begin and not cond.in_math }
  ),
  as({ trig = ":url", dscr = "URL" },
    fmta([[\url{<>}]], { d(1, util.get_visual) }),
    { condition = condse.line_begin and not cond.in_math }
  ),
  as({ trig = ":ref", dscr = "Reference" },
    fmta([[\ref{<>}<>]], { i(1, "name"), i(0) }),
    { condition = condse.line_begin and not cond.in_math }
  ),

  as({ trig = ":href", dscr = "Reference" },
    fmta([[\href{<>}{<>}]], { i(1, "URL"), i(0, "title") }),
    { condition = condse.line_begin and not cond.in_math }
  ),
  as({ trig = ":cref", dscr = "Reference with cleveref" },
    fmta([[<>\cref{<>}]], { f(util.capture), d(1, util.get_visual) }),
    { condition = condse.line_begin and not cond.in_math }
  ),

  as({ trig = ":label", dscr = "Label" },
    fmta([[\label{<>}]], { d(1, util.get_visual) }),
    { condition = condse.line_begin and not cond.in_math }
  ),
  as({ trig = ":caption", dscr = "URL" },
    fmta([[\caption{<>}]], { d(1, util.get_visual) }),
    { condition = condse.line_begin and not cond.in_math }
  ),
  as({ trig = ":cmd", dscr = "Number" },
    fmta([[\newcommand{<>}{<>}]], { i(1), i(0) }),
    { condition = condse.line_begin and not cond.in_math }
  ),
  as({ trig = ":num", dscr = "Number" },
    fmta([[\num{<>}]], { d(1, util.get_visual) }),
    { condition = condse.line_begin and not cond.in_math }
  ),
  as({ trig = "url", dscr = "URL" },
    fmta([[\url{<>}]], { d(1, util.get_visual) }),
    { condition = condse.line_begin and not cond.in_math }
  ),
  as({ trig = "url", dscr = "URL" },
    fmta([[\url{<>}]], { d(1, util.get_visual) }),
    { condition = condse.line_begin and not cond.in_math }
  ),
}
return snippets
