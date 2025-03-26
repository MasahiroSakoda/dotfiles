-- -*-mode:lua-*- vim:ft=lua

---@see https://github.com/go-delve/delve/blob/master/Documentation/usage/dlv_dap.md
return {
  {
    name    = "Debug File",
    type    = "delve",
    request = "launch",
    showLog = true,
    program = "${file}",
  },
  {
    name    = "Debug Package",
    type    = "delve",
    request = "launch",
    showLog = true,
    program = "${fileDirname}",
  },
  {
    name      = "Attach Process",
    type      = "delve",
    mode      = "local",
    request   = "attach",
    processId = require("dap.utils").pick_process,
  },
  {
    type = "go",
    name = "Debug test",
    request = "launch",
    mode = "test",
    program = "${file}",
    showLog = true,
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
  },
}
