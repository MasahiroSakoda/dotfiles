-- -*-mode:lua-*- vim:ft=lua

---@param callback fun(arg: table): any
---@param config table<string, any>
---@return any
return function(callback, config)
  local stdout, stderr = vim.uv.new_pipe(false), vim.uv.new_pipe(false)
  local handle, pid_or_err
  local host = config.host or "127.0.0.1"
  local port = config.port or "38697"
  local opts = {
    stdio    = { nil, stdout, stderr },
    args     = { "dap", "-l", string.format("%s:%s", host, port) },
    detected = true,
  }

  handle, pid_or_err = vim.uv.spawn("dlv", opts, function(code)
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
  vim.defer_fn(function() callback({
    type = "server",
    host = host,
    port = port,
    executable = {
      command = "dlv",
      args = { "dap", "-l", "127.0.0.1:${port}" },
    },
  }) end, 100)
end
