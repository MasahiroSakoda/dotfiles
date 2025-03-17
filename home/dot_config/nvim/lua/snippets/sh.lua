-- -*-mode:lua-*- vim:ft=lua
local ls = require("luasnip")
local s = ls.snippet
local fmt = require("luasnip.extras.fmt").fmt

local snippets = {
  s("#!", fmt('#! /usr/bin/env bash\nset -euo pipefail', {})),
}
return snippets
