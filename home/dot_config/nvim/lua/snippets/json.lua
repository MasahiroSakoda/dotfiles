-- -*-mode:lua-*- vim:ft=lua
local ls = require("luasnip")
---@diagnostic disable-next-line: unused-local
local s, t, i, c, r, f, sn =
  ls.snippet,ls.text_node, ls.insert_node, ls.choice_node, ls.restore_node, ls.function_node, ls.snippet_node
---@diagnostic disable-next-line: unused-local
local fmt, fmta = require("luasnip.extras.fmt").fmt, require("luasnip.extras.fmt").fmta
---@diagnostic disable-next-line: unused-local
local conds, condse = require("luasnip.extras.conditions"), require("luasnip.extras.conditions.expand")

local snippets = {
  s({ trig = "obj", name = "primary object", dscr = "primary json object" },
    fmt([[
      {{
        "{}": {}
      }}
    ]], { i(1, "key"), i(2, "value") })
  ),
  s({ trig = "pair", name = "key-value pair", dscr = "key-value pair object content" },
    fmt('"{}": {},', { i(1, "key"), i(2, "value") })
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
    ]], { i(1, "key1"), i(2, "value2"), i(3, "key2"), i(4, "value2") })
  ),
  s({ trig = "list", name = "list object", dscr = "list object" },
    fmt([[
      [
        {},
        {},
        {}
      ]
    ]], { i(1, "value1"), i(2, "value2"), i(3, "value3") })
  ),
}
return snippets
