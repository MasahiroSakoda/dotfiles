-- -*-mode:lua-*- vim:ft=lua
local venv = os.getenv('VIRTUAL_ENV')
local pkg = "debugpy"

return {
  {
    type       = "python",
    request    = "launch",
    name       = "Debug single file",
    cwd        = "${workspaceFolder}",
    program    = "${file}",
    pythonPath = venv and (venv .. "/bin/python") or
      vim.fn.stdpath("data") .. "mason/packages/" .. pkg .. "/venv/bin/python3"
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
