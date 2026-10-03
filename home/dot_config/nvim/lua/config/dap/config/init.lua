-- -*-mode:lua-*- vim:ft=lua

return {
  c               = require("config.dap.config.cpp"),
  cpp             = require("config.dap.config.cpp"),
  rust            = require("config.dap.config.cpp"),
  go              = require("config.dap.config.go"),
  python          = require("config.dap.config.python"),
  ruby            = require("config.dap.config.ruby"),
  lua             = require("config.dap.config.lua"),
  javascript      = require("config.dap.config.javascript"),
  typescript      = require("config.dap.config.javascript"),
  javascriptreact = require("config.dap.config.javascript"),
  typescriptreact = require("config.dap.config.javascript"),
}
