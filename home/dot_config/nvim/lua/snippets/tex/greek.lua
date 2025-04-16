-- -*-mode:lua-*- vim:ft=lua
---@diagnostic disable: unused-local
local ls = require("luasnip")
local s  = ls.snippet
local t  = ls.text_node

local snippets = {
  s({ trig = ";a", name = "alpha",   dscr = "alpha",   snippetType = "autosnippet" }, t("\\alpha")),
  s({ trig = ";b", name = "beta",    dscr = "beta",    snippetType = "autosnippet" }, t("\\beta")),
  s({ trig = ";c", name = "chi",     dscr = "chi",     snippetType = "autosnippet" }, t("\\chi")),
  s({ trig = ";d", name = "delta",   dscr = "delta",   snippetType = "autosnippet" }, t("\\delta")),
  s({ trig = ";D", name = "Delta",   dscr = "Delta",   snippetType = "autosnippet" }, t("\\Delta")),
  s({ trig = ";e", name = "eta",     dscr = "eta",     snippetType = "autosnippet" }, t("\\eta")),
  s({ trig = ";f", name = "phi",     dscr = "phi",     snippetType = "autosnippet" }, t("\\phi")),
  s({ trig = ";g", name = "gamma",   dscr = "gamma",   snippetType = "autosnippet" }, t("\\gamma")),
  s({ trig = ";G", name = "Gamma",   dscr = "Gamma",   snippetType = "autosnippet" }, t("\\Gamma")),
  s({ trig = ";i", name = "iota",    dscr = "iota",    snippetType = "autosnippet" }, t("\\iota")),
  s({ trig = ";k", name = "kappa",   dscr = "kappa",   snippetType = "autosnippet" }, t("\\kappa")),
  s({ trig = ";l", name = "lambda",  dscr = "lambda",  snippetType = "autosnippet" }, t("\\lambda")),
  s({ trig = ";L", name = "Lambda",  dscr = "Lambda",  snippetType = "autosnippet" }, t("\\Lambda")),
  s({ trig = ";m", name = "mu",      dscr = "mu",      snippetType = "autosnippet" }, t("\\mu")),
  s({ trig = ";n", name = "nu",      dscr = "nu",      snippetType = "autosnippet" }, t("\\nu")),
  s({ trig = ";o", name = "omicron", dscr = "omicron", snippetType = "autosnippet" }, t("\\omicron")),
  s({ trig = ";p", name = "pi",      dscr = "pi",      snippetType = "autosnippet" }, t("\\pi")),
  s({ trig = ";P", name = "Pi",      dscr = "Pi",      snippetType = "autosnippet" }, t("\\Pi")),
  s({ trig = ";q", name = "theta",   dscr = "theta",   snippetType = "autosnippet" }, t("\\theta")),
  s({ trig = ";q", name = "Theta",   dscr = "Theta",   snippetType = "autosnippet" }, t("\\Theta")),
  s({ trig = ";r", name = "rho",     dscr = "rho",     snippetType = "autosnippet" }, t("\\rho")),
  s({ trig = ";s", name = "sigma",   dscr = "sigma",   snippetType = "autosnippet" }, t("\\sigma")),
  s({ trig = ";S", name = "Sigma",   dscr = "Sigma",   snippetType = "autosnippet" }, t("\\Sigma")),
  s({ trig = ";t", name = "tau",     dscr = "tau",     snippetType = "autosnippet" }, t("\\tau")),
  s({ trig = ";u", name = "upsilon", dscr = "upsilon", snippetType = "autosnippet" }, t("\\upsilon")),
  s({ trig = ";U", name = "Upsilon", dscr = "Upsilon", snippetType = "autosnippet" }, t("\\Upsilon")),
  s({ trig = ";w", name = "omega",   dscr = "omega",   snippetType = "autosnippet" }, t("\\omega")),
  s({ trig = ";W", name = "Omega",   dscr = "Omega",   snippetType = "autosnippet" }, t("\\Omega")),
  s({ trig = ";x", name = "xi",      dscr = "xi",      snippetType = "autosnippet" }, t("\\xi")),
  s({ trig = ";X", name = "Xi",      dscr = "Xi",      snippetType = "autosnippet" }, t("\\Xi")),
  s({ trig = ";y", name = "psi",     dscr = "psi",     snippetType = "autosnippet" }, t("\\psi")),
  s({ trig = ";Y", name = "Psi",     dscr = "Psi",     snippetType = "autosnippet" }, t("\\Psi")),
  s({ trig = ";z", name = "zeta",    dscr = "zeta",    snippetType = "autosnippet" }, t("\\zeta")),
}
return snippets
