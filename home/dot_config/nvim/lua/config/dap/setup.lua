local ok, dap = pcall(require, "dap")
if not ok then return end

dap.listeners.before.launch.dapui_config           = function() vim.cmd("DapViewOpen") end
dap.listeners.before.attach.dapui_config           = function() vim.cmd("DapViewOpen") end
dap.listeners.before.event_terminated.dapui_config = function() vim.cmd("DapViewClose") end
dap.listeners.before.event_exited.dapui_config     = function() vim.cmd("DapViewClose") end

require("dap.ext.vscode").json_decode = require("overseer.json").decode
-- https://github.com/stevearc/overseer.nvim/blob/master/doc/third_party.md#dap
require("overseer").enable_dap()

local bp = {
  breakpoint = { text = " ", texthl = "LspDiagnosticsSignError", linehl = "", numhl = "" },
  rejected   = { text = " ", texthl = "LspDiagnosticsSignHint",  linehl = "", numhl = "" },
  stopped    = {
    text   = "➤ ",
    texthl = "LspDiagnosticsSignInformation",
    linehl = "DiagnosticUnderlineInfo",
    numhl  = "LspDiagnosticsSignInformation",
  },
}

vim.fn.sign_define("DapBreakpoint",         bp.breakpoint)
vim.fn.sign_define("DapBreakpointRejected", bp.rejected)
vim.fn.sign_define("DapStopped",            bp.stopped)

for name, adapter in pairs(require("debugger.adapters")) do
  if not dap.adapters[name] then
    dap.adapters[name] = adapter
  end
end

for filetype, configs in pairs(require("debugger.config")) do
  if not dap.configurations[filetype] then
    dap.configurations[filetype] = configs
  end
end
