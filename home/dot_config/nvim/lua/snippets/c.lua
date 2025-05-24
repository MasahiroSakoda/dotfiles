-- -*-mode:lua-*- vim:ft=lua
local ls = require("luasnip")
local s  = ls.snippet
-- local t  = ls.text_node
local i  = ls.insert_node
-- local c  = ls.choice_node
-- local d  = ls.dynamic_node
-- local r  = ls.restore_node
-- local f  = ls.function_node
-- local sn = ls.snippet_node
-- local as = ls.extend_decorator.apply(s, { snippetType = "autosnippet" })
-- local extras = require("luasnip.extras")
-- local rep    = extras.rep
-- local m      = extras.m
-- local l      = extras.l
local fmt     = require("luasnip.extras.fmt").fmt
local fmta    = require("luasnip.extras.fmt").fmta
-- local postfix = require("luasnip.extras.postfix").postfix
-- local conds   = require("luasnip.extras.conditions")
-- local condse  = require("luasnip.extras.conditions.expand")

ls.filetype_extend("c",      { "cdoc" })

local snippets = {
  s({ trig = "main", name = "main", dscr = "main func" },
    fmta('#include <stdio.h>\n\nint main(){\n\t<>\n\treturn 0;\n}', { i(0) })
  ),
  s({ trig = "include", name = "include", dscr = "include" },
    fmt('#include {}', { i(0) })
  ),
  s({ trig = "print", name = "printf", dscr = "printf" },
    fmt('printf("{}");', { i(0) })
  ),
}
return snippets
