-- -*-mode:lua-*- vim:ft=lua

return {
  name = "Golang build",
  condition = { filetype = { "go" } },

  builder = function()
    return {
      cmd = { "go", "build", "-v", "./..." },
      components = {
        { "on_output_quickfix", set_diagnostics = true },
        "on_result_diagnostics",
        "default",
      },
    }
  end
}
