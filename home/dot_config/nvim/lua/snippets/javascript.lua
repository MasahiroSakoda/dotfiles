-- -*-mode:lua-*- vim:ft=lua
local ls = require("luasnip")
---@diagnostic disable-next-line: unused-local
local s, t, i, c, r, f, sn =
  ls.snippet,ls.text_node, ls.insert_node, ls.choice_node, ls.restore_node, ls.function_node, ls.snippet_node
---@diagnostic disable-next-line: unused-local
local fmt, fmta = require("luasnip.extras.fmt").fmt, require("luasnip.extras.fmt").fmta
---@diagnostic disable-next-line: unused-local
local conds, condse = require("luasnip.extras.conditions"), require("luasnip.extras.conditions.expand")
---@diagnostic disable-next-line: unused-local
local rep = require("luasnip.extras").rep

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
