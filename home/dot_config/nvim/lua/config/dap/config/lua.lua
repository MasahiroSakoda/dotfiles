-- -*-mode:lua-*- vim:ft=lua

return {
  {
    name    = "Attach to running Neovim instance",
    type    = "nlua",
    request = "attach",
    host = "127.0.0.1",
    port = function()
      local co = coroutine.running()
      vim.ui.input({ prompt = "Port: " }, function(input)
        coroutine.resume(co, tonumber(input))
      end)
      return coroutine.yield()
    end,
  },
}
