-- -*-mode:lua-*- vim:ft=lua
local filetypes = require("user.filetypes")

return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      { "theHamsta/nvim-dap-virtual-text", config = function() require("dap.config.virtual_text") end },
      { "rcarriga/nvim-dap-ui" },
    },
    cmd    = { "DapToggleBreakpoint", "DapContinue", "DapTerminate", "DapStepOver", "DapStepInto", "DapStepOut" },
    config = function() require("dap.config") end,
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
