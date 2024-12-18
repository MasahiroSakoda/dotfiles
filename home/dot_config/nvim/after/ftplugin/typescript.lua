-- -*-mode:lua-*- vim:ft=lua

local adapter = require("dap.adapters.javascript")
adapter.dap_adapter({ "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" })
adapter.dap_configuration({ "typescript" })
