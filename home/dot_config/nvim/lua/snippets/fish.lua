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
  s("path",  fmt('fish_add_path {}',   { i(1, "path") })),
  s("setx",  fmt('set -x {} {}',       { i(1, "arg1"), i(2, "arg2") })),
  s("setlx", fmt('set -lx {} {}',      { i(1, "arg1"), i(2, "arg2") })),
  s("setgx", fmt('set -gx {} {}',      { i(1, "arg1"), i(2, "arg2") })),
  s("bind",  fmt('bind {} {}',         { i(1, "arg1"), i(2, "arg2") })),
  s("cmd",   fmt('command {}',         { i(1, "arg") })),
  s("abbr",  fmt('abbr -a -- {} "{}"', { i(1, "shorthand"), i(2, "command") })),

  s("if",    fmt('if {}\n\t{}\nend',        { i(1, "condition"), i(2, "code") })),
  s("elif",  fmt('else if {} {}',           { i(1, "condition"), i(2, "code") })),
  s("for",   fmt('for {} in {}\n\t{}\nend', { i(1, "var"),       i(2, "list"), i(3, "code") })),
  s("while", fmt('while {}\n\t{}\nend',     { i(1, "condition"), i(2, "code") })),

  s("fn",    fmt('function {} --description "{}"\n\t{}\nend', { i(1, "func"), i(2, "desc"), i(0, "code") })),
}

return snippets
