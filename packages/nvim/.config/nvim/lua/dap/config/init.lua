local dap_ok,   dap   = pcall(require, "dap")
local dapui_ok, dapui = pcall(require, "dap-ui")
if not (dap_ok or dapui_ok) then return end

dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end

dap.listeners.after.event_terminated["dapui_config"] = function()
  dapui.close()
end

dap.listeners.after.event_exited["dapui_config"] = function()
  dapui.open()
end

local bp = {
  breakpoint = {
    text   = "􀌛 ",
    texthl = "LspDiagnosticsSignError",
    linehl = "",
    numhl  = "",
  },
  rejected = {
    text   = "􀌚 ",
    texthl = "LspDiagnosticsSignHint",
    linehl = "",
    numhl  = "",
  },
  stopped  = {
    text   = "􁂎 ",
    texthl = "LspDiagnosticsSignInformation",
    linehl = "DiagnosticUnderlineInfo",
    numhl  = "LspDiagnosticsSignInformation",
  },
}

local fn  = vim.fn
fn.sign_define("DapBreakpoint",         bp.breakpoint)
fn.sign_define("DapStopped",            bp.breakpoint)
fn.sign_define("DapBreakpointRejected", bp.breakpoint)

-- require("dap.adapters.cppdbg")
-- require("dap.adapters.codelldb")
