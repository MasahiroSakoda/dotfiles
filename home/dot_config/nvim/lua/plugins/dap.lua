-- -*-mode:lua-*- vim:ft=lua
local filetypes = require("user.filetypes")

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

  {
    "microsoft/vscode-js-debug",
    build = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out",
    ft    = filetypes.lang.js,
    cond  = not vim.g.vscode,
  },
  {
    "mxsdev/nvim-dap-vscode-js",
    ft = filetypes.lang.js,
    config = function() require("dap.adapters.javascript") end,
  },
}
