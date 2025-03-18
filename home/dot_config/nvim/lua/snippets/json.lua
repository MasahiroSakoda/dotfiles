-- -*-mode:lua-*- vim:ft=lua
local ls = require("luasnip")
local s  = ls.snippet
-- local t  = ls.text_node
local i  = ls.insert_node
-- local c  = ls.choice_node
-- local r  = ls.restore_node
-- local f  = ls.function_node
-- local sn = ls.snippet_node
-- local extras = require("luasnip.extras")
-- local rep    = extras.rep
-- local m      = extras.m
-- local l      = extras.l
local fmt    = require("luasnip.extras.fmt")
-- local fmta   = require("luasnip.extras.fmta")
-- local conds  = require("luasnip.extras.conditions")
-- local condse = require("luasnip.extras.conditions.expand")

local snippets = {
  s({ trig = "obj", name = "primary object", dscr = "primary json object" },
    fmt([[
      {{
        "{}": {}
      }}
      {}
    ]], { i(1, "key"), i(2, "value"), i(0) })
  ),
  s({ trig = "pair", name = "key-value pair", dscr = "key-value pair object content" },
    fmt('"{}": {},\n{}', { i(1, "key"), i(2, "value"), i(0) })
  ),
  s({ trig = "array", name = "array object", dscr = "array object" },
    fmt([[
      [
        {{
          "{}": {},
        }},
        {{
          "{}", {},
        }},
      ]
      {}
    ]], { i(1, "key1"), i(2, "value2"), i(3, "key2"), i(4, "value2"), i(0) })
  ),
  s({ trig = "list", name = "list object", dscr = "list object" },
    fmt([[
      [
        {},
        {},
        {}
      ]
      {}
    ]], { i(1, "value1"), i(2, "value2"), i(3, "value3"), i(0) })
  ),
}
return snippets
