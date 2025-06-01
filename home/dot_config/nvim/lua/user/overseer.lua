-- -*-mode:lua-*- vim:ft=lua
local ok, overseer = pcall(require, "overseer")
if not ok then return end

overseer.setup({
  -- DO NOT add chezmoi attributed prefix (e.g. "run_*")
  -- See also: https://www.chezmoi.io/reference/source-state-attributes/
  templates = { "builtin" },
  task_list = {
    direction  = "bottom", ---@type "left"|"right"|"bottom"
    min_height = 10,
    max_height = 15,
    default_detail = 1, ---@type 1|2|3
  },
  dap = false,
  strategy = {
    "toggleterm",
    use_shell = false,
    direction     = nil,      ---@type nil|"vertical"|"horizontal"|"tab"|"float"
    close_on_exit = true,
    quit_on_exit  = "always", ---@type "always"|"success"|"never"
    open_on_start = true,
    auto_scroll   = true,
  },
})

-- Latest task command
vim.api.nvim_create_user_command("OverseerRestartLast", function()
  local tasks = overseer.list_tasks({ recent_first = true })
  if vim.tbl_isempty(tasks) then
    vim.notify("No tasks found", vim.log.levels.WARN)
  else
    overseer.run_action(tasks[1], "restart")
  end
end, {})

-- Async make command
vim.api.nvim_create_user_command("Make", function(params)
  -- Insert args at the '$*' in the makeprg
  local cmd, num_subs = vim.o.makeprg:gsub("%$%*", params.args)
  if num_subs == 0 then cmd = cmd .. " " .. params.args end
  local task = require("overseer").new_task({
    cmd = vim.fn.expandcmd(cmd),
    components = {
      { "on_output_quickfix", open = not params.bang, open_height = 8 },
      "unique",
      "default",
    },
  })
  task:start()
end, { desc = "Run your makeprg as an Overseer task", nargs = "*", bang = true })
