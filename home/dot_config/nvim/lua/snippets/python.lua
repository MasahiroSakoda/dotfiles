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

ls.filetype_extend("python", { "pydoc", "django" })

local snippets = {
  s({ trig = "imp", name = "import package", dscr = "import package template" },
    fmt('{}', { c(1, {
      sn(nil, { t("import "), i(1, "package"), c(2, { t(""), sn(nil, t(" as "), i(1, "alias")) }) } ),
      sn(nil, { t("from "), i(1, "package"), t(" import "), i(2, "*") }),
    }) })
  ),

  s({ trig = "imp3", name = "import 3rd party lib", dscr = "import 3rd pary library" },
    fmt('import {}\n', { c(1, {
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
    }) })
  ),
}
return snippets
