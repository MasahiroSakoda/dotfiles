-- -*-mode:lua-*- vim:ft=lua

return {
  name = "Golang test",
  condition = { filetype = { "go" } },

  builder = function()
    return {
      cmd = { "go", "test", "-v", "./..." },
      components = {
        { "on_output_quickfix", set_diagnostics = true },
        "on_result_diagnostics",
        "default",
      },
    }
  end
}
