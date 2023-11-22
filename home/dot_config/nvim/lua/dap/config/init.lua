local dap_ok,   dap   = pcall(require, "dap")
local dapui_ok, dapui = pcall(require, "dapui")
if not (dap_ok or dapui_ok) then return end

dapui.setup({
  icons = {
    expanded      = "",
    collapsed     = "",
    circular      = "",
    current_frame = ""
  },

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
  -- Use this to override mappings for specific elements
  element_mappings = {
    -- Example:
    -- stacks = {
    --   open = "<CR>",
    --   expand = "o",
    -- },
  },
  expand_lines = vim.fn.has("nvim-0.7") == 1,
  render = {
    indent = 2,
    max_type_length = nil, -- Can be integer or nil.
    max_value_lines = 30, -- Can be integer or nil.
  },

  layouts = {
    {
      elements = {
        { id = "scopes",      size = 0.40 },
        { id = "breakpoints", size = 0.20 },
        { id = "stacks",      size = 0.25 },
        -- { id = "watches",     size = 0.25 },
      },
      size = 35,
      position = "left",
    },
    {
      elements = {
        { id = "repl",    size = 0.55 },
        { id = "console", size = 0.45 },
      },
      size = 0.30,
      position = "bottom",
    },
  },
  floating = {
    max_height = nil, -- These can be integers or a float between 0 and 1.
    max_width  = nil, -- Floats will be treated as percentage of your screen.
    border = "rounded", -- Border style. Can be "single", "double" or "rounded"
    mappings = {
      close = { "q", "<Esc>" },
    },
  },

  controls = {
    enabled = true,
    element = "repl",
    icons = {
      pause     = "",
      play      = "",
      step_into = "",
      step_over = "",
      step_out  = "",
      step_back = "",
      run_last  = "↻",
      terminate = "",
    },
  },
  force_buffers = false,
})

dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end

dap.listeners.after.event_terminated["dapui_config"] = function()
  dapui.close()
end

dap.listeners.after.event_exited["dapui_config"] = function()
  dapui.open()
end

local bp = {
  breakpoint = {
    text   = " ",
    texthl = "LspDiagnosticsSignError",
    linehl = "",
    numhl  = "",
  },
  rejected = {
    text   = " ",
    texthl = "LspDiagnosticsSignHint",
    linehl = "",
    numhl  = "",
  },
  stopped  = {
    text   = "➤ ",
    texthl = "LspDiagnosticsSignInformation",
    linehl = "DiagnosticUnderlineInfo",
    numhl  = "LspDiagnosticsSignInformation",
  },
}

local fn  = vim.fn
fn.sign_define("DapBreakpoint",         bp.breakpoint)
fn.sign_define("DapBreakpointRejected", bp.rejected)
fn.sign_define("DapStopped",            bp.stopped)

-- require("dap.adapters.cppdbg")
-- require("dap.adapters.codelldb")
