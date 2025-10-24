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

ls.filetype_extend("cpp", { "cppdoc" })

local snippets = {
  s({ trig = "head", name = "standard header", dscr = "standard header template" },
    fmta('#include <<>>\n<>', { c(1, {
      t("iostream"),
      t("string"),
      t("arraay"),
      t("list"),
      t("vector"),
      t("map"),
      t("set"),
      t("algorithm"),
      t("thread"),
      t("memory"),
      i(0),
    }) })
  ),
  s({ trig = "main", name = "main func", dscr = "main function template" }, fmta([[
    #include <iostream>

    using namespace std;

    int main(int argc, char *argv[]) {
        <>
        cout << "" << endl;
        return 0;
    }
    <>
  ]], { i(1, "code"), i(0) })),

  s({ trig = "class", name = "class definition", dscr = "class definition template" },
    fmta('class <> {\npublic:\n\t<>\nprotected:\nprivate:\n};\n<>', { i(1, "member"), i(0) })
  )
}
return snippets
