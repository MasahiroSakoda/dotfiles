-- -*-mode:lua-*- vim:ft=lua

return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
    },
    cmd    = { "DapToggleBreakpoint", "DapContinue", "DapTerminate", "DapStepOver", "DapStepInto", "DapStepOut" },
    config = function() require("debugger.setup") end,
  },
  {
    "igorlfs/nvim-dap-view",
    dependencies = { "mfussenegger/nvim-dap" },
    cmd    = { "DapViewToggle", "DapViewWatch", "DapViewJump", "DapViewShow", "DapViewNavigate" },
    config = function() require("debugger.view") end,
  },
  {
    "theHamsta/nvim-dap-virtual-text",
    dependencies = { "mfussenegger/nvim-dap", "nvim-treesitter/nvim-treesitter" },
    config = function() require("debugger.virtual_text") end,
  },
  { "jbyuki/one-small-step-for-vimkind", ft = "lua" },
  {
    "microsoft/vscode-js-debug",
    build  = { "npm install", "npx gulp vsDebugServerBundle", "mv dist out" },
    ft     = require("user.filetypes").lang.js,
    config = function() require("debugger.config.js") end,
  },
}
