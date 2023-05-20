local ok, scrollbar = pcall(require, "scrollbar")
if not ok then return end

scrollbar.setup({
  show_in_active_only = true,
  max_lines = false, -- disables if no. of lines in buffer exceeds this
  throttle_ms = 100,

  excluded_buftypes = {
    "terminal",
    "nofile",
  },
  excluded_filetypes = {
    "prompt",
    "notify",
    "quickfix",
    "alpha",
    "dashboard",
    "neo-tree",
    "neo-tree-popup",
    "dapui_scopes",
    "dapui_breakpoints",
    "dapui_stacks",
    "dapui_hover",
    "dapui_watches",
    "dapui_console",
    "dap-repl",
    "startuptime",
    "TelescopePrompt",
    "Trouble",
  },
  handlers = {
    cursor     = true,
    diagnostic = true,
    gitsigns   = true, -- Requires gitsigns
    handle     = true,
    search     = true, -- Requires hlslens
    ale        = false, -- Requires ALE

  },
})
