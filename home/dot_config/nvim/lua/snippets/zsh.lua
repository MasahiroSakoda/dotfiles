-- -*-mode:lua-*- vim:ft=lua
---@diagnostic disable: unused-local
local ls = require("luasnip")
local s  = ls.snippet
local t  = ls.text_node     -- luacheck: no unused
local i  = ls.insert_node   -- luacheck: no unused
local c  = ls.choice_node   -- luacheck: no unused
local d  = ls.dynamic_node  -- luacheck: no unused
local r  = ls.restore_node  -- luacheck: no unused
local f  = ls.function_node -- luacheck: no unused
local sn = ls.snippet_node  -- luacheck: no unused
local extras = require("luasnip.extras")
local rep    = extras.rep   -- luacheck: no unused
local m      = extras.m     -- luacheck: no unused
local l      = extras.l     -- luacheck: no unused
local fmt     = require("luasnip.extras.fmt").fmt
local fmta    = require("luasnip.extras.fmt").fmta          -- luacheck: no unused
local postfix = require("luasnip.extras.postfix").postfix   -- luacheck: no unused
local conds   = require("luasnip.extras.conditions")        -- luacheck: no unused
local condse  = require("luasnip.extras.conditions.expand") -- luacheck: no unused

local snippets = {
  s("exp",  fmt('export {}={}\n{}', { i(1, "variable"), i(2, "value"), i(0) })),
  s("loc",  fmt('local {}={}\n{}',  { i(1, "variable"), i(2, "value"), i(0) })),

  s("func", fmt('function {}({}) {{\n\t{}\n}}\n{}', { i(1, "name"), i(2, "parameter"), i(3, "code"), i(0) })),
  s("for",  fmt('for {} in {} do\n\t{}\ndone\n{}',  { i(1, "item"), i(2, "list"), i(3, "code"), i(0) })),

  s("if",   fmt('if {} ; then\n\t{}\nfi\n{}', { i(1, "condition"), i(2, "code"), i(0) }))

}
return snippets
