local ok, dap = pcall(require, "mason-nvim-dap")
if not ok then return end

dap.setup({
  -- Makes a best effort to setup the various debuggers with
  -- reasonable debug configurations
  automatic_setup = true,

  -- You can provide additional configuration to the handlers,
  -- see mason-nvim-dap README for more information
  handlers = {},

  -- You'll need to check that you have the required things installed
  -- online, please don't ask me how to install them :)
  ensure_installed = require("dap.adapters"),
  -- ensure_installed = {
  --   "bash",     -- bash-debug-adapter
  --   "codelldb", -- codelldb: C, C++, Rust
  --   "cppdbg",   -- cpptools: C, C++, Rust
  --   "delve",    -- Go
  --   "python",   -- Python
  --   "js",       -- JavaScript, TypeScript
  --   "chrome",   -- Google Chrome
  -- },
})
