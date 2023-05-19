local ok, dap = pcall(require, "dap")
if not ok then return end

-- https://github.com/mfussenegger/nvim-dap/wiki/C-C---Rust-(via--codelldb)
dap.adapters.codelldb = {
  type = "server",
  port = "${port}",
  executable = {
    command = "~/.local/share/nvim/mason/bin/codelldb",
    args = { "--port", "${port}" },
    -- On windows you may have to uncomment this:
    -- detached = false,
  },
}

-- C, CPP, and Rust use codelldb.
dap.adapters.c    = dap.adapters.codelldb
dap.adapters.cpp  = dap.adapters.codelldb
dap.adapters.rust = dap.adapters.codelldb

dap.configurations.cpp = {
  {
    name    = "Launch file",
    type    = "codelldb",
    request = "launch",
    program = function()
      return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
    end,
    cwd     = '${workspaceFolder}',
    stopOnEntry   = false,
    runInTerminal = false,
  },
}

dap.configurations.c    = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp
