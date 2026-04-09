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
    cmd = { "DapViewToggle", "DapViewWatch", "DapViewJump", "DapViewShow", "DapViewNavigate" },
  },
  { "jbyuki/one-small-step-for-vimkind", ft = "lua" },
}
