local ok, dapui = pcall(require, "dapui")
if not ok then return end

dapui.setup({
  icons = { expanded = "", collapsed = "", circular = "" },

  mappings = {
    -- Use a table to apply multiple mappings
    expand = { "<CR>", "<2-LeftMouse>" },
    open   = "o",
    remove = "d",
    edit   = "e",
    repl   = "r",
    toggle = "t",
    close  = { "q", "<ESC>" },
  },

  layouts = {
    {
      elements = {
        { id = "scopes",      size = 0.33 },
        { id = "breakpoints", size = 0.17 },
        { id = "stacks",      size = 0.20 },
        { id = "watches",     size = 0.20 },
      },
      size = 0.25,
      position = "left",
    },
    {
      elements = {
        { id = "repl",    size = 0.45 },
        { id = "console", size = 0.55 },
      },
      size = 0.25,
      position = "bottom",
    },
  },

  controls = {
    enabled = true,
    element = "repl",
    icons = {
      pause     = "",
      play      = "",
      step_into = "",
      step_over = "",
      step_out  = "",
      step_back = "",
      run_last  = "↻",
      terminate = "□",
    },
  },
})
