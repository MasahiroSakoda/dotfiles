return {
  bash     = {},                                 -- bash-debug-adapter
  codelldb = require("dap.adapters.codelldb"),   -- codelldb: C, C++, Rust
  -- cppdbg   = require("dap.adapters.cppdbg"),     -- cpptools: C, C++, Rust
  delve    = require("dap.adapters.delve"),      -- Go
  python   = require("dap.adapters.python"),     -- Python
  js       = require("dap.adapters.javascript"), -- JavaScript, TypeScript
  chrome   = require("dap.adapters.chrome"),     -- Google Chrome
}
