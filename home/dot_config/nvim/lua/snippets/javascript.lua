-- -*-mode:lua-*- vim:ft=lua
local ls = require("luasnip")
local s, t, i, c = ls.snippet,ls.text_node, ls.insert_node, ls.choice_node
local fmt = require("luasnip.extras.fmt").fmt

local snippets = {
  s({ trig = "console", name = "console log/warn/error", dscr = "console output templates" },
    fmt('console.{}({})', {
      c(1, { t("log"), t("warn"), t("error") }),
      i(2, "variable"),
    })
  ),

  s({ trig = "js", name = "json stringify/parse", dscr = "json stringify or parse template" },
    fmt('JSON.{}({})', { c(1, { t("stringify"), t("parse") }), i(2, "variable") })
  ),
}
return snippets
