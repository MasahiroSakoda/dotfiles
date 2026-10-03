-- -*-mode:lua-*- vim:ft=lua

return {
  ["codelldb"]   = require("config.dap.adapters.codelldb"),
  ["delve"]      = require("config.dap.adapters.delve"),
  ["debugpy"]    = require("config.dap.adapters.debugpy"),
  ["ruby"]       = require("config.dap.adapters.ruby"),
  ["nlua"]       = require("config.dap.adapters.nlua"),
}
