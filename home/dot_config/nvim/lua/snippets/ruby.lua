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

ls.filetype_extend("ruby",   { "rdoc", "rails" })

local snippets = {
  -- Rails
  s("controller", fmt('class {}Controller < ApplicationController\n\t{}\nend', { i(1, "name"), i(0, "code") })),
  s("helper",     fmt('module {}Helper\n\t{}\nend', { i(1, "name"), i(0, "code") })),

  -- Rspec
  s("rspec", fmt('require "{}_helper"\n\nRspec.describe {}{} do\n\t{}\nend', {
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
  })),
  s("testf", fmt('require "test_helper"\n\nclass {}Test < ActiveSupport::TestCase\n\t{}\nend', {
    i(1, "name"),
    i(2, "code"),
  })),
  s("it", fmt('{} do\n\t{}\nend', {
    c(1, {
      fmt('it "{}"', { i(1, "desc") }),
      fmt('specify "{}"', i(1, "desc")),
    }),
    i(0, "code"),
  }))
}
return snippets
