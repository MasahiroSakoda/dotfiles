-- -*-mode:lua-*- vim:ft=lua

return {
  name = "Run Python script",
  condition = {
    filetypes = { "python" },
  },

  builder = function()
    return {
      cmd  = { "python3" },
      args = { vim.fn.expand("%p") },
      cwd  = vim.fn.getcwd(),
      components = {
        { "on_output_quickfix", set_diagnostics = true, open = true },
        "on_result_diagnostics",
        "default",
      },
    }
  end,
}
