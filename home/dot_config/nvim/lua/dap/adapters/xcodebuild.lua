local ok, dap = pcall(require, "dap")
if not ok then return end

dap.configurations.swift = {
  {
    name    = "iOS App Debugger",
    type    = "codelldb",
    request = "attach",
    -- this will wait until the app is launched
    pid = require("xcodebuild.dap").wait_for_pid,
    cwd = "${workspaceFolder}",
    stopOnEntry = false,
  },
}

dap.adapters.codelldb = {
  type = "server",
  port = "${port}",
  executable = {
    command = vim.fn.stdpath("data") .. "/mason/packages/codelldb/extension/adapters/codelldb",
    args = {
      "--port",
      "${port}",
      "--liblldb",
      "/Applications/Xcode.app/Contents/SharedFrameworks/LLDB.framework/Versions/A/LLDB",
    },
  },
}
