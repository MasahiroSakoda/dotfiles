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

ls.filetype_extend("cpp", { "cppdoc" })

local snippets = {
  s({ trig = "head", name = "standard header", dscr = "standard header template" },
    fmt('#include <{}>\n{}', { c(1, {
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
      t("iostream"),
      t("iostream"),
      i(0),
    }) })
  ),
  s({ trig = "main", name = "main func", dscr = "main function template" }, fmt([[
    #include <iostream>

    using namespace std;

    int main(int argc, char *argv[]) {{
        {}
        cout << "" << endl;
        return 0;
    }}
    {}
  ]], { i(1, "code"), i(0) })),

  s({ trig = "class", name = "class definition", dscr = "class definition template" }, fmt([[
    class {} {{
    public:
        {}
    protected:
    private:
    }};
    {}
  ]], { i(1, "member"), i(0) })),
}
return snippets
