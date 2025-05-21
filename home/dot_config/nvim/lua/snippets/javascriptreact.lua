-- -*-mode:lua-*- vim:ft=lua
---@diagnostic disable: unused-local
local ls = require("luasnip")
local s  = ls.snippet
local t  = ls.text_node
local i  = ls.insert_node
local c  = ls.choice_node
-- local d  = ls.dynamic_node
-- local r  = ls.restore_node
local f  = ls.function_node
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
  s({ trig = "st", name = "useState", dscr = "useState" },
    fmta('const [<>, <>] = useState(<>)', {
      i(1),
      f(function(args) return args[1][1]:gsub("^%l", string.upper) end, { 1 }),
      i(0),
    })
  ),
  s({ trig = "ef", name = "useEffect", dscr = "useEffect" },
    fmta('useEffect(() => {\n\t<>\n}<>);', { c(1, { t(""), t(", []") }), i(0) })
  ),
  s({ trig = "async func", name = "async func", dscr = "async func" },
    fmta([[
<>async function <>(): Promise<<>> {
  <>
}
    ]], { c(1, { t(""), t("export") }), i(2), i(3), i(0) })
  ),

}
return snippets
