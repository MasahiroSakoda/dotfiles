local ok, dap = pcall(require, "dap")
if not ok then return end

--------------------------------------------------
-- DAP configuration for Python
--------------------------------------------------
local venv = os.getenv('VIRTUAL_ENV')

dap.adapters.python = {
  type    = "executable";
  command = require("utils.mason").install_path("debugpy") .. "/debugpy-adapter",
}

dap.configurations.python = {
  {
    type       = "python",
    request    = "launch",
    name       = "launch File",
    cwd        = "${workspaceFolder}",
    program    = "${file}",
    pythonPath = venv and (venv .. '/bin/python') or nil,
  },
}
