-- -*-mode:lua-*- vim:ft=lua
---@diagnostic disable: unused-local
local ls = require("luasnip")
local s  = ls.snippet
local t  = ls.text_node
local i  = ls.insert_node
local c  = ls.choice_node
local d  = ls.dynamic_node
local r  = ls.restore_node
local f  = ls.function_node
local sn = ls.snippet_node
local extras = require("luasnip.extras")
local rep    = extras.rep
local m      = extras.m
local l      = extras.l
local fmt     = require("luasnip.extras.fmt").fmt
local fmta    = require("luasnip.extras.fmt").fmta
local postfix = require("luasnip.extras.postfix").postfix
local conds   = require("luasnip.extras.conditions")
local condse  = require("luasnip.extras.conditions.expand")

ls.filetype_extend("python", { "pydoc", "django" })

local snippets = {
  s({ trig = "imp", name = "import package", dscr = "import package template" },
    fmt('{}\n{}', { c(1, {
      sn(nil, { t("import "), i(1, "package"), c(2, { t(""), sn(nil, t(" as "), i(1, "alias")) }) } ),
      sn(nil, { t("from "), i(1, "package"), t(" import "), i(2, "*") }),
      i(0),
    }) })
  ),

  s({ trig = "imp3", name = "import 3rd party lib", dscr = "import 3rd pary library" },
    fmt('import {}\n{}', { c(1, {
      t("numpy as np"),
      t("scipy as sp"),
      t("pandas as pd"),
      t("matplotlib.pyplot as plt"),
      t("tensorflow as tf"),
      t("torch"),
      t("torch.nn as nn"),
      t("torch.nn.funcional as F"),
      t("torch.optim as optim"),
      t("torchvision"),
      t("torchvision.transforms as transforms"),
      t("torchvision.datasets as datasets"),
      t("torchvision.utils as utils"),
      t("torchvision.models as models"),
      t("torch.utils.data as data"),
      i(0)
    }) })
  ),
}
return snippets
