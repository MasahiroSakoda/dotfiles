-- -*-mode:lua-*- vim:ft=lua

local adapter = require("dap.adapters.javascript")
adapter.dap_adapter({ "pwa-node", "pwa-chrome" })
adapter.dap_configuration({ "typescript.tsx", "typescriptreact" })
