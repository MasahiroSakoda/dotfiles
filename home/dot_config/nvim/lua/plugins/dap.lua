-- -*-mode:lua-*- vim:ft=lua

return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
    },
    cmd    = { "DapToggleBreakpoint", "DapContinue", "DapTerminate", "DapStepOver", "DapStepInto", "DapStepOut" },
    config = function() require("dap.config") end,
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" }
  },
  {
    "theHamsta/nvim-dap-virtual-text",
    dependencies = { "mfussenegger/nvim-dap", "nvim-treesitter/nvim-treesitter" },
    config = function() require("dap.config.virtual_text") end,
  },
  { "jbyuki/one-small-step-for-vimkind" },
  {
    "microsoft/vscode-js-debug",
    build  = { "npm install", "npx gulp vsDebugServerBundle", "mv dist out" },
    ft     = require("user.filetypes").lang.js,
    config = function() require("dap.config.js") end,
  },
}
