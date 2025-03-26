-- -*-mode:lua-*- vim:ft=lua

---@see https://github.com/go-delve/delve/blob/master/Documentation/usage/dlv_dap.md
return {
  {
    name    = "Debug File",
    type    = "delve",
    request = "launch",
    showLog = true,
    program = "${file}",
    dlvToolPath = vim.fn.exepath("dlv"),
  },
  {
    name    = "Debug Package",
    type    = "delve",
    request = "launch",
    showLog = true,
    program = "${fileDirName}",
    dlvToolPath = vim.fn.exepath("dlv"),
  },
  {
    name      = "Attach Process",
    type      = "delve",
    mode      = "local",
    request   = "attach",
    processId = require("dap.utils").pick_process,
    dlvToolPath = vim.fn.exepath("dlv"),
  },
  {
    type = "go",
    name = "Debug test",
    request = "launch",
    mode = "test",
    program = "${file}",
    showLog = true,
    dlvToolPath = vim.fn.exepath("dlv"),
  },
  {
    name    = "Debug test (go.mod)",
    type    = "delve",
    request = "launch",
    mode    = "test",
    cwd     = "${workspaceFolder}",
    program = "./${relativeFileDirname}",
    console = "integratedTerminal",
    showLog = true,
    dlvToolPath = vim.fn.exepath("dlv"),
  },
}
