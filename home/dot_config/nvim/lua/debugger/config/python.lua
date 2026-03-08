-- -*-mode:lua-*- vim:ft=lua

return {
  {
    type       = "python",
    request    = "launch",
    name       = "Debug single file",
    cwd        = "${workspaceFolder}",
    program    = "${file}",
    pythonPath = function()
      local venvPython = vim.loop.cwd() .. "/.venv/bin/python"
      return vim.fn.executable(venvPython) == 1 and venvPython or "python"
    end,
  },
  {
    type    = "python",
    request = "attach",
    name    = "Attach to process",
    host    = "127.0.0.1",
    port    = 5678,
  },
  {
    type    = "python",
    request = "launch",
    name    = "Debug Django Project",
    program = "${workspaceFolder}/manage.py",
    args    = { "runserver", "--noreload" },
  },
}
