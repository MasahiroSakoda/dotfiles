local ok, dap = pcall(require, "dap")
if not ok then return end

---@param callback fun(arg: table): any
---@param config table<string, any>
---@return any
dap.adapters.go = function(callback, config)
  local stdout, stderr = vim.uv.new_pipe(false), vim.uv.new_pipe(false)
  local handle, pid_or_err
  local host = config.host or "127.0.0.1"
  local port = config.port or "38697"
  local opts = {
    stdio    = { nil, stdout, stderr },
    args     = { "dap", "-l", string.format("%s:%s", host, port) },
    detected = true,
  }

  handle, pid_or_err = vim.loop.spawn("dlv", opts, function(code)
    if stdout ~= nil and stderr ~= nil then
      stdout:close()
      stderr:close()
    end
    handle:close()
    if code ~= 0 then vim.notify("dlv exited with code " .. code, vim.log.levels.WARN) end
  end)
  assert(handle, "Error running dlv: " .. tostring(pid_or_err))

  local onread = function(err, chunk)
    assert(not err, err)
    if chunk then vim.schedule(function() require("dap.repl").append(chunk) end) end
  end

  if stdout ~= nil and stderr ~= nil then
    stdout:read_start(onread)
    stderr:read_start(onread)
  end

  -- Wait for delve to start
  vim.defer_fn(function() callback({ type = "server", host = host, port = port }) end, 100)
end

---@see https://github.com/go-delve/delve/blob/master/Documentation/usage/dlv_dap.md
dap.configurations.go = {
  {
    name    = "Debug File",
    type    = "go",
    request = "launch",
    showLog = true,
    program = "${file}",
    dlvToolPath = vim.fn.exepath("dlv"),
  },
  {
    name    = "Debug Package",
    type    = "go",
    request = "launch",
    showLog = true,
    program = "${fileDirName}",
    dlvToolPath = vim.fn.exepath("dlv"),
  },
  {
    name      = "Attach Process",
    type      = "go",
    mode      = "local",
    request   = "attach",
    processId = function()
      return require("dap.utils").pick_process({ filter = vim.fn.input("Process Name: ") })
    end,
    dlvToolPath = vim.fn.exepath("dlv"),
  },
  {
    name    = "Debug test (go.mod)",
    type    = "go",
    request = "launch",
    mode    = "test",
    cwd     = "${workspaceFolder}",
    program = "./${relativeFileDirname}",
    console = "integratedTerminal",
    showLog = true,
    dlvToolPath = vim.fn.exepath("dlv"),
  },
}
