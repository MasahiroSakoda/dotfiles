-- -*-mode:lua-*- vim:ft=lua
local ls = require("luasnip")
local s, i = ls.snippet,ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

local snippets = {
  s({ trig = "path", name = "path",    dscr = "fish_add_path template" },
    fmt('fish_add_path {}', { i(1, "path") })
  ),
  s({ trig = "setx", name = "set -x",  dscr = "var definition" },
    fmt('set -x {} {}', { i(1, "arg1"), i(2, "arg2") })
  ),
  s({ trig = "setlx", name = "set -lx", dscr = "var definition (local)" },
    fmt('set -lx {} {}', { i(1, "arg1"), i(2, "arg2") })
  ),
  s({ trig = "setgx", name = "set -gx", dscr = "var definition (global)" },
    fmt('set -gx {} {}', { i(1, "arg1"), i(2, "arg2") })
  ),
  s({ trig = "bind", name = "bind", dscr = "keybind definitionn" },
    fmt('bind {} {}', { i(1, "arg1"), i(2, "arg2") })
  ),
  s({ trig = "cmd", name = "command", dscr = "represent command" },
    fmt('command {}', { i(1, "arg") })
  ),
  s({ trig = "abbr", name = "abbreviation", dscr = "fish abbriviation" },
    fmt('abbr -a -- {} "{}"', { i(1, "shorthand"), i(2, "command") })
  ),

  s({ trig = "if", name = "if - end", dscr = "if - end block template" },
    fmt('if {}\n\t{}\nend', { i(1, "condition"), i(2, "code") })
  ),
  s({ trig = "elif", name = "else if", dscr = "else if block" },
    fmt('else if {} {}', { i(1, "condition"), i(2, "code") })
  ),
  s({ trig = "for", name = "for loop", dscr = "for loop block" },
    fmt('for {} in {}\n\t{}\nend', { i(1, "var"),       i(2, "list"), i(3, "code") })
  ),
  s({ trig = "while", name = "while loop", dscr = "while loop block" },
    fmt('while {}\n\t{}\nend', { i(1, "condition"), i(2, "code") })
  ),

  s({ trig = "fn", name = "function", dscr = "function definition" },
    fmt('function {} --description "{}"\n\t{}\nend', { i(1, "func"), i(2, "desc"), i(0, "code") })
  ),
}

return snippets
