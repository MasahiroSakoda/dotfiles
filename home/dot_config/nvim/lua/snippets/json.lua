-- -*-mode:lua-*- vim:ft=lua
local ls = require("luasnip")
local s, i = ls.snippet, ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

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
