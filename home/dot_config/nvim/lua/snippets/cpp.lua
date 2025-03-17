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

ls.filetype_extend("cpp", { "cppdoc" })

local snippets = {
  s({ trig = "head", name = "standard header", dscr = "standard header template" },
    fmt('#include <{}>\n', { c(1, {
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
  ]], { i(1, "code") })),

  s({ trig = "class", name = "class definition", dscr = "class definition template" }, fmt([[
    class {} {{
    public:
        {}
    protected:
    private:
    }};
  ]], { i(1, "member") })),
}
return snippets
