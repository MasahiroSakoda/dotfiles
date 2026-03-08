-- -*-mode:lua-*- vim:ft=lua

-- https://github.com/mfussenegger/nvim-dap/wiki/C-C---Rust-(via--codelldb)
return {
  type = "server",
  port = "${port}",
  executable = {
    command = "codelldb",
    args = { "--port", "${port}" },
    -- On windows you may have to uncomment this:
    -- detached = false,
  },
}
