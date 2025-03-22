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
