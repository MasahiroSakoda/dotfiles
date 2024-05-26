-- -*-mode:lua-*- vim:ft=lua

local ok, overseer = pcall(require, "overseer")
if not ok then return end

overseer.setup({
  task_list = {
    direction  = "bottom",
    min_height = 25,
    max_height = 25,
    default_detail = 1, ---@type 1|2|3
  },
  dap = false,
  -- TODO: integration with `toggleterm`
  -- strategy = {
  --   "toggleterm",
  --   use_shell = false,
  --   -- have the toggleterm window close and delete the terminal buffer automatically after the task exits
  --   close_on_exit = false,
  --   -- have the toggleterm window close without deleting the terminal buffer
  --   -- automatically after the task exits
  --   quit_on_exit = "never", ---@type "always"|"success"|"never"
  --   -- open the toggleterm window when a task starts
  --   open_on_start = true,
  -- },
  templates = {
    "builtin",
    "user",
  },
})
