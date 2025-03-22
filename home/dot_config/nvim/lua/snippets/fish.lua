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
local fmt     = require("luasnip.extras.fmt").fmt
-- local fmta    = require("luasnip.extras.fmt").fmta
-- local postfix = require("luasnip.extras.postfix").postfix
-- local conds   = require("luasnip.extras.conditions")
-- local condse  = require("luasnip.extras.conditions.expand")

local snippets = {
  s({ trig = "path", name = "path",    dscr = "fish_add_path template" },
    fmt('fish_add_path {}\n{}', { i(1, "path"), i(0) })
  ),
  s({ trig = "setx", name = "set -x",  dscr = "var definition" },
    fmt('set -x {} {}\n{}', { i(1, "arg1"), i(2, "arg2"), i(0) })
  ),
  s({ trig = "setlx", name = "set -lx", dscr = "var definition (local)" },
    fmt('set -lx {} {}\n{}', { i(1, "arg1"), i(2, "arg2"), i(0) })
  ),
  s({ trig = "setgx", name = "set -gx", dscr = "var definition (global)" },
    fmt('set -gx {} {}\n{}', { i(1, "arg1"), i(2, "arg2"), i(0) })
  ),
  s({ trig = "bind", name = "bind", dscr = "keybind definitionn" },
    fmt('bind {} {}\n{}', { i(1, "arg1"), i(2, "arg2"), i(0) })
  ),
  s({ trig = "cmd", name = "command", dscr = "represent command" },
    fmt('command {}\n{}', { i(1, "arg"), i(0) })
  ),
  s({ trig = "abbr", name = "abbreviation", dscr = "fish abbriviation" },
    fmt('abbr -a -- {} "{}"\n{}', { i(1, "shorthand"), i(2, "command"), i(0) })
  ),

  s({ trig = "if", name = "if - end", dscr = "if - end block template" },
    fmt('if {}\n\t{}\nend\n{}', { i(1, "condition"), i(2, "code"), i(0) })
  ),
  s({ trig = "elif", name = "else if", dscr = "else if block" },
    fmt('else if {} {}\n{}', { i(1, "condition"), i(2, "code"), i(0) })
  ),
  s({ trig = "for", name = "for loop", dscr = "for loop block" },
    fmt('for {} in {}\n\t{}\nend\n{}', { i(1, "var"),       i(2, "list"), i(3, "code"), i(0) })
  ),
  s({ trig = "while", name = "while loop", dscr = "while loop block" },
    fmt('while {}\n\t{}\nend\n{}', { i(1, "condition"), i(2, "code"), i(0) })
  ),

  s({ trig = "fn", name = "function", dscr = "function definition" },
    fmt('function {} --description "{}"\n\t{}\nend\n{}', { i(1, "func"), i(2, "desc"), i(0, "code"), i(0) })
  ),
}

return snippets
