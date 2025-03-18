-- -*-mode:lua-*- vim:ft=lua
local ls = require("luasnip")
local s, t, i, c = ls.snippet,ls.text_node, ls.insert_node, ls.choice_node
local fmt = require("luasnip.extras.fmt").fmt

ls.filetype_extend("ruby",   { "rdoc", "rails" })

local snippets = {
  -- Rails
  s("controller", fmt('class {}Controller < ApplicationController\n\t{}\nend\n{}', { i(1, "name"), i(2, "code"), i(0) })),
  s("helper",     fmt('module {}Helper\n\t{}\nend\n{}', { i(1, "name"), i(2, "code"), i(0) })),

  -- Rspec
  s("rspec", fmt('require "{}_helper"\n\nRspec.describe {}{} do\n\t{}\nend\n{}', {
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
  })),
  s("testf", fmt('require "test_helper"\n\nclass {}Test < ActiveSupport::TestCase\n\t{}\nend\n{}', {
    i(1, "name"),
    i(2, "code"),
    i(0),
  })),
  s("it", fmt('{} do\n\t{}\nend\n{}', {
    c(1, {
      fmt('it "{}"', { i(1, "desc") }),
      fmt('specify "{}"', i(1, "desc")),
    }),
    i(2, "code"),
    i(0),
  }))
}
return snippets
