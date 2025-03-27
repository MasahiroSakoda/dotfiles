-- -*-mode:lua-*- vim:ft=lua

return {
  ["bashdb"]     = require("debugger.adapters.bashdb"),
  ["codelldb"]   = require("debugger.adapters.codelldb"),
  ["delve"]      = require("debugger.adapters.delve"),
  ["debugpy"]    = require("debugger.adapters.debugpy"),
  ["ruby"]       = require("debugger.adapters.ruby"),
  ["nlua"]       = require("debugger.adapters.nlua"),
  ["pwa-node"]   = require("debugger.adapters.pwa-node"),
  ["pwa-chrome"] = require("debugger.adapters.pwa-chrome"),
}
