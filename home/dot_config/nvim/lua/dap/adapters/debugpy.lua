local ok, dap = pcall(require, "dap")
if not ok then return end

--------------------------------------------------
-- DAP configuration for Python
--------------------------------------------------
local path = require("mason-registry").get_package("debugpy"):get_install_path() .. "/debugpy-adapter"
local venv = os.getenv('VIRTUAL_ENV')

dap.adapters.python = {
  type    = "executable";
  command = path,
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
