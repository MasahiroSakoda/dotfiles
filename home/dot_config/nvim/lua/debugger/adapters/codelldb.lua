-- -*-mode:lua-*- vim:ft=lua
local package = "codelldb"

-- https://github.com/mfussenegger/nvim-dap/wiki/C-C---Rust-(via--codelldb)
return {
  type = "server",
  port = "${port}",
  executable = {
    command = vim.fn.stdpath("data") .. "/mason/bin/" .. package,
    args = { "--port", "${port}" },
    -- On windows you may have to uncomment this:
    -- detached = false,
  },
}
