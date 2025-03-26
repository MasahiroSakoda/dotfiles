-- -*-mode:lua-*- vim:ft=lua

return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
    },
    cmd    = { "DapToggleBreakpoint", "DapContinue", "DapTerminate", "DapStepOver", "DapStepInto", "DapStepOut" },
    opts = {
      adapters       = require("debugger.adapters"),
      configurations = require("debugger.config"),
    },
    config = function() require("debugger.setup") end,
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio",
      { "mortepau/codicons.nvim", config = function() require("ui.codicons") end },
    }
  },
  {
    "theHamsta/nvim-dap-virtual-text",
    dependencies = { "mfussenegger/nvim-dap", "nvim-treesitter/nvim-treesitter" },
    config = function() require("debugger.virtual_text") end,
  },
  { "jbyuki/one-small-step-for-vimkind" },
  {
    "microsoft/vscode-js-debug",
    build  = { "npm install", "npx gulp vsDebugServerBundle", "mv dist out" },
    ft     = require("user.filetypes").lang.js,
    config = function() require("debugger.config.js") end,
  },
}
