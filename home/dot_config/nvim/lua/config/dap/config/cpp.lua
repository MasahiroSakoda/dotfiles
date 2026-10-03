-- -*-mode:lua-*- vim:ft=lua

return {
  {
    name    = "Launch file",
    type    = "codelldb",
    request = "launch",
    program = function()
      return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
    end,
    cwd     = "${workspaceFolder}",
    stopOnEntry   = false,
    runInTerminal = false,
  },
}
