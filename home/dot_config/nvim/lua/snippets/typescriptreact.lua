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
-- local as = ls.extend_decorator.apply(s, { snippetType = "autosnippet" })
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
  -- React directives
  s({ trig = ";uc", name = "use client", dscr = "use client directive" }, fmta('"use client"', {}) ),
  s({ trig = ";us", name = "use server", dscr = "use server directive" }, fmta('"use server"', {}) ),

  -- INFO: React hooks leave it to friendly snippets

  -- Class name
  s({ trig = "cn", name = "cn() className helper" }, fmta('cn(<>)', { i(0, "Class name") }) ),
  s({ trig = "cva", name = "cva() variant definition" },
    fmta([[
      const <> = cva("<>", {
        variants: {
          <>
        }
      })
    ]], { i(1, "variants"), i(2, "base-classes"), i(3, "") })
  ),
}
return snippets
