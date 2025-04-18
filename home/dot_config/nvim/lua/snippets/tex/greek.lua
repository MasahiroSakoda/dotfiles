-- -*-mode:lua-*- vim:ft=lua
---@diagnostic disable: unused-local
local ls = require("luasnip")
local s  = ls.snippet
local t  = ls.text_node
local as = ls.extend_decorator.apply(s, { snippetType = "autosnippet" })

local snippets = {
  as({ trig = ";a", dscr = "alpha"   }, t("\\alpha")),
  as({ trig = ";b", dscr = "beta"    }, t("\\beta")),
  as({ trig = ";c", dscr = "chi"     }, t("\\chi")),
  as({ trig = ";d", dscr = "delta"   }, t("\\delta")),
  as({ trig = ";D", dscr = "Delta"   }, t("\\Delta")),
  as({ trig = ";e", dscr = "eta"     }, t("\\eta")),
  as({ trig = ";f", dscr = "phi"     }, t("\\phi")),
  as({ trig = ";g", dscr = "gamma"   }, t("\\gamma")),
  as({ trig = ";G", dscr = "Gamma"   }, t("\\Gamma")),
  as({ trig = ";i", dscr = "iota"    }, t("\\iota")),
  as({ trig = ";k", dscr = "kappa"   }, t("\\kappa")),
  as({ trig = ";l", dscr = "lambda"  }, t("\\lambda")),
  as({ trig = ";L", dscr = "Lambda"  }, t("\\Lambda")),
  as({ trig = ";m", dscr = "mu"      }, t("\\mu")),
  as({ trig = ";n", dscr = "nu"      }, t("\\nu")),
  as({ trig = ";o", dscr = "omicron" }, t("\\omicron")),
  as({ trig = ";p", dscr = "pi"      }, t("\\pi")),
  as({ trig = ";P", dscr = "Pi"      }, t("\\Pi")),
  as({ trig = ";q", dscr = "theta"   }, t("\\theta")),
  as({ trig = ";q", dscr = "Theta"   }, t("\\Theta")),
  as({ trig = ";r", dscr = "rho"     }, t("\\rho")),
  as({ trig = ";s", dscr = "sigma"   }, t("\\sigma")),
  as({ trig = ";S", dscr = "Sigma"   }, t("\\Sigma")),
  as({ trig = ";t", dscr = "tau"     }, t("\\tau")),
  as({ trig = ";u", dscr = "upsilon" }, t("\\upsilon")),
  as({ trig = ";U", dscr = "Upsilon" }, t("\\Upsilon")),
  as({ trig = ";w", dscr = "omega"   }, t("\\omega")),
  as({ trig = ";W", dscr = "Omega"   }, t("\\Omega")),
  as({ trig = ";x", dscr = "xi"      }, t("\\xi")),
  as({ trig = ";X", dscr = "Xi"      }, t("\\Xi")),
  as({ trig = ";y", dscr = "psi"     }, t("\\psi")),
  as({ trig = ";Y", dscr = "Psi"     }, t("\\Psi")),
  as({ trig = ";z", dscr = "zeta"    }, t("\\zeta")),
}
return snippets
