-- -*-mode:lua-*- vim:ft=lua
---@diagnostic disable: unused-local
local ls = require("luasnip")
local s  = ls.snippet
local t  = ls.text_node
local i  = ls.insert_node
local c  = ls.choice_node
local d  = ls.dynamic_node
local r  = ls.restore_node
local f  = ls.function_node
local sn = ls.snippet_node
local extras = require("luasnip.extras")
local rep    = extras.rep
local m      = extras.m
local l      = extras.l
local fmt     = require("luasnip.extras.fmt").fmt
local fmta    = require("luasnip.extras.fmt").fmta
local postfix = require("luasnip.extras.postfix").postfix
local conds   = require("luasnip.extras.conditions")
local condse  = require("luasnip.extras.conditions.expand")

local snippets = {

  s({ trig = "nxp", name = "Next.js page", dscr = "Next.js page" },
    fmt([[
      export default function {}({}) {{
        return (
          {}
        )
      }}
    ]], { i(1, "Page Name"), i(2, "Parameters"), i(0) })
  ),
}
return snippets
