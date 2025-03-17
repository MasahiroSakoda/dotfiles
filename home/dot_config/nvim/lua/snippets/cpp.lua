-- -*-mode:lua-*- vim:ft=lua
local ls = require("luasnip")
local s, t, i, c = ls.snippet,ls.text_node, ls.insert_node, ls.choice_node
local fmt = require("luasnip.extras.fmt").fmt

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
