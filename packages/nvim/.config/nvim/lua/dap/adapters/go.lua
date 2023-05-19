local ok, dap = pcall(require, "dap")
if not ok then return end

local fn, loop = vim.fn, vim.loop
dap.adapters.go = function(callback, config)
  local handle, pid_or_err, port = nil, nil, 12346
  handle, pid_or_err = loop.spawn("dlv", {
    args = { "dap", "-l", "127.0.0.1:", port },
    detached = true,
    cwd = loop.cwd,
  }, vim.schedule_wrap(function(code)
      handle:close()
      print("Delve has exited with: " .. code)
  end))

  if not handle then error("Failed:", pid_or_err) end

  vim.defer_fn(function()
    callback {
      type = "server",
      host = "127.0.0.1",
      port = port
    }
  end, 100)
end

dap.configurations.go = {
  {
    type    = "go",
    name    = "Debug",
    request = "launch",
    showLog = true,
    program = "${file}",
    dlvToolPath = fn.exepath "dlv"
  },
  {
    type    = "go",
    name    = "Test Current File",
    request = "launch",
    mode    = "test",
    showLog = true,
    program = ".",
    dlvToolPath = fn.exepath "dlv"
  },
}
