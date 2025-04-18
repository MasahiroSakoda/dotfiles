-- -*-mode:lua-*- vim:ft=lua
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
  s({ trig = "path",  dscr = "fish_add_path" },   fmta('fish_add_path <>',  { i(0, "path") })),
  s({ trig = "setx",  dscr = "var definition" },  fmta('set -x <> <>',  { i(1, "var"), i(2, "content") })),
  s({ trig = "setlx", dscr = "local variable" },  fmta('set -lx <> <>', { i(1, "var"), i(2, "content") })),
  s({ trig = "setgx", dscr = "global variable" }, fmta('set -gx <> <>', { i(1, "var"), i(2, "content") })),
  s({ trig = "bind",  dscr = "keybind" },         fmta('bind <> <>',    { i(1, "key"), i(2, "cmd") })),

  s({ trig = "cmd",   dscr = "represent cmd" },   fmta('command <>',         { i(0) })),
  s({ trig = "abbr",  dscr = "fish abbrev" },     fmta('abbr -a -- <> "<>"', { i(1), i(0) })),

  s({ trig = "if",    dscr = "if - end" }, fmta('if <>\n\t<>\nend\n',        { i(1), i(2) })),
  s({ trig = "elif",  dscr = "else if" },  fmta('else if <> <>\n',           { i(1), i(2) })),
  s({ trig = "for",   dscr = "for loop" }, fmta('for <> in <>\n\t<>\nend\n', { i(1), i(2), i(3) })),
  s({ trig = "while", dscr = "while" },    fmta('while <>\n\t<>\nend\n',     { i(1), i(2) })),
  s({ trig = "fn",    dscr = "function" }, fmta('function <> --description "<>"\n\t<>\nend\n', { i(1), i(2), i(0) })),
}

return snippets
