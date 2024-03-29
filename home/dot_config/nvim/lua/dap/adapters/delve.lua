local ok, dap = pcall(require, "dap")
if not ok then return end

local dlv_path = vim.fn.exepath("dlv")

-- dap.adapters.go = {
--   type = "server",
--   port = "${port}",
--   executable = {
--     command = dlv_path,
--     args = { "dap", "-l", "127.0.0.1:${port}" },
--   },
-- }

dap.adapters.go = function(callback, _)
  local stdout = vim.loop.new_pipe(false)
  local handle, pid_or_err
  local port = 38697

  handle, pid_or_err = vim.loop.spawn("dlv", {
    stdio = { nil, stdout },
    args  = { "dap", "-l", "127.0.0.1:" .. port },
    detected = true,
  }, function(code)
    stdout:close()
    handle:close()
    if code ~= 0 then
      print("[delve] Exit Code:", code)
    end
  end)

  assert(handle, "Error running dlv: " .. tostring(pid_or_err))

  stdout:read_start(function(err, chunk)
    assert(not err, err)
    if chunk then
      vim.schedule(function()
        require("dap.repl").append(chunk)
        print("[delve]", chunk)
      end)
    end
  end)

  -- Wait for delve to start
  vim.defer_fn(function()
    callback { type = "server", host = "127.0.0.1", port = port }
  end, 100)
end

dap.configurations.go = {
  {
    type    = "go",
    name    = "Debug",
    request = "launch",
    showLog = true,
    program = "${file}",
    dlvToolPath = dlv_path,
  },
  {
    type    = "go",
    name    = "Test Current File",
    request = "launch",
    mode    = "test",
    showLog = true,
    program = ".",
    dlvToolPath = dlv_path,
  },
  {
    type    = "go",
    name    = "Debug test (go.mod)",
    request = "launch",
    mode    = "test",
    program = "./${relativeFileDirname}",
    dlvToolPath = dlv_path,
  },
}
