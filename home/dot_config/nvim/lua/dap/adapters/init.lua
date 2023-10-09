return {
  bash     = {},                                 -- bash-debug-adapter
  codelldb = require("dap.adapters.codelldb"),   -- codelldb: C, C++, Rust
  cpptools = require("dap.adapters.cpptools"),   -- cpptools: C, C++, Rust
  delve    = require("dap.adapters.delve"),      -- Go
  debugpy  = require("dap.adapters.debugpy"),    -- Python
  js       = require("dap.adapters.javascript"), -- JavaScript, TypeScript
  chrome   = require("dap.adapters.chrome"),     -- Google Chrome
}
