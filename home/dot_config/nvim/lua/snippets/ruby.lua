-- -*-mode:lua-*- vim:ft=lua
local ls = require("luasnip")
local s  = ls.snippet
local t  = ls.text_node
local i  = ls.insert_node
local c  = ls.choice_node
-- local r  = ls.restore_node
-- local f  = ls.function_node
-- local sn = ls.snippet_node
-- local extras = require("luasnip.extras")
-- local rep    = extras.rep
-- local m      = extras.m
-- local l      = extras.l
local fmt    = require("luasnip.extras.fmt").fmt
-- local fmta   = require("luasnip.extras.fmta")
-- local conds  = require("luasnip.extras.conditions")
-- local condse = require("luasnip.extras.conditions.expand")

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
