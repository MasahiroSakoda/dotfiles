local ok, dap = pcall(require, "dap")
if not ok then return end

--------------------------------------------------
-- DAP configuration for Python
--------------------------------------------------
local venv = os.getenv('VIRTUAL_ENV')
dap.adapters.python = {
  type = "executable";
  command = string.format("%s/bin/python", venv),
  args = { "-m", "debugpy.adapter" },
}

dap.configurations.python = {
  {
    type    = "python",
    request = "launch",
    name    = "launch File",
    program = "${file}",
    pythonPath = function()
      if venv == nil then
        return "python"
      else
        return venv .. "/bin/python"
      end
    end
  },
}
