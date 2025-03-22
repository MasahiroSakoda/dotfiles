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

ls.filetype_extend("ruby",   { "rdoc", "rails" })

local snippets = {
  -- Rails
  s({ trig = "controller", name = "Rails Controller", dscr = "Rails controller component" },
    fmt([[
      class {}Controller < ApplicationController
        {}
      end
      {}
    ]], { i(1, "name"), i(2, "code"), i(0) })
  ),
  s({ trig = "helper", name = "Rails Helper", dscr = "Rails helper component" },
    fmt([[
      module {}Helper
        {}
      end
      {}
    ]], { i(1, "name"), i(2, "code"), i(0) })
  ),

  -- Rspec
  s({ trig = "rspec", name = "Rspec template", dscr = "Rspec file template" },
    fmt('require "{}_helper"\n\nRspec.describe {}{} do\n\t{}\nend\n{}', {
      c(1, {t("spec"), t("rails")}),
      i(2),
      c(3, {
        fmt(', type: :{}', { i(1) }),
        t(""),
        t(", type: :model"),
        t(", type: :controller"),
        t(", type: :request"),
        t(", type: :job"),
        t(", type: :policy"),
      }),
      i(0),
    })
  ),
  s({ trig = "testf", name = "Rails test helper", dscr = "Rails test component" },
    fmt('require "test_helper"\n\nclass {}Test < ActiveSupport::TestCase\n\t{}\nend\n{}', {
      i(1, "name"), i(2, "code"), i(0),
    })
  ),
  s({ trig = "it", name = "Rails test assert", dscr = "Rails test component" },
    fmt('{} do\n\t{}\nend\n{}', {
      c(1, {
        fmt('it "{}"', { i(1, "desc") }),
        fmt('specify "{}"', i(1, "desc")),
      }),
      i(2, "code"),
      i(0),
    })
  )
}
return snippets
