-- -*-mode:lua-*- vim:ft=lua

--------------------------------------------------
-- DAP configuration for Ruby
--------------------------------------------------
return function(callback, config)
  callback({
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
  })
end
