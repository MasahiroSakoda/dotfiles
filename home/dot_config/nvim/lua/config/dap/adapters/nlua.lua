-- -*-mode:lua-*- vim:ft=lua

---@param callback fun(arg: table): any
---@param config table<string, any>
---@return any
return function(callback, config)
  callback({ type = 'server', host = config.host or "127.0.0.1", port = config.port or 8086 })
end
