local ok, dap = pcall(require, "dap")
if not ok then return end

--------------------------------------------------
-- DAP configuration for Ruby
--------------------------------------------------
dap.adapters.ruby = function(callback, config)
  callback {
    type = "server",
    host = "127.0.0.1",
    port = "${port}",
    executable = {
      command = "bundle",
      args = {
        "exec", "rdbg", "-n", "--open", "--port", "${port}", "-c", "--",
        "bundle", "exec", config.command, config.script,
      },
    },
  }
end

dap.configurations.ruby = {
  {
    type    = "ruby",
    name    = "debug current file",
    bundle  = "",
    request = "attach",
    command = "ruby",
    script  = "${file}",
    server  = "127.0.0.1",
    port    = 38698,
    wanting = 1000,
  },
  {
    type    = "ruby",
    name    = "run current test file",
    bundle  = "bundle",
    request = "attach",
    command = "rails test",
    script  = "${file}",
    server  = "127.0.0.1",
    port    = 38698,
    wanting = 1000,
  },
  {
    type    = "ruby",
    name    = "run test",
    bundle  = "bundle",
    request = "attach",
    command = "rails test",
    script  = "./test",
    server  = "127.0.0.1",
    port    = 38698,
    wanting = 1000,
  },
  {
    type    = "ruby",
    name    = "run current spec file",
    localfs = true,
    request = "attach",
    command = "rspec",
    script  = "${file}",
  },
  {
    type    = "ruby",
    name    = "run rspec",
    bundle  = "bundle",
    request = "attach",
    command = "rspec",
    script  = "./spec",
    server  = "127.0.0.1",
    port    = 38698,
    waiting = 1000,
  },
}
