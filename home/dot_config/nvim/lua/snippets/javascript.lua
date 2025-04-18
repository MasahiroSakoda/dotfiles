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
-- local extras = require("luasnip.extras")
-- local rep    = extras.rep
-- local m      = extras.m
-- local l      = extras.l
-- local fmt     = require("luasnip.extras.fmt").fmt
local fmta    = require("luasnip.extras.fmt").fmta
-- local postfix = require("luasnip.extras.postfix").postfix
-- local conds   = require("luasnip.extras.conditions")
-- local condse  = require("luasnip.extras.conditions.expand")

local snippets = {
  s({ trig = "console", name = "console log/warn/error", dscr = "console output templates" },
    fmta('console.<>(<>)\n<>', {
      c(1, { t("log"), t("warn"), t("error") }),
      i(2, "variable"),
      i(0),
    })
  ),

  s({ trig = "js", name = "json stringify/parse", dscr = "json stringify or parse template" },
    fmta('JSON.<>(<>)\n<>', { c(1, { t("stringify"), t("parse") }), i(2, "variable"), i(0) })
  ),
}
return snippets
