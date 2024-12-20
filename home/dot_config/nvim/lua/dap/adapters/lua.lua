local ok, dap = pcall(require, "dap")
if not ok then return end

---@param callback fun(arg: table): any
---@param config table<string, any>
---@return any
dap.adapters.nlua = function(callback, config)
  callback({ type = 'server', host = config.host or "127.0.0.1", port = config.port or 8086 })
end

dap.configurations.lua = {
  {
    name    = "Attach to running Neovim instance",
    type    = "nlua",
    request = "attach",
  },
}
