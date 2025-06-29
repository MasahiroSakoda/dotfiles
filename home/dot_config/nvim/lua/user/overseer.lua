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
  strategy = { "jobstart" },
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

vim.api.nvim_create_user_command("Grep", function(params)
  local args = vim.fn.expandcmd(params.args)
  local cmd, num_subs = vim.o.grepprg:gsub("%$%*", args)
  if num_subs == 0 then
    cmd = cmd .. " " .. args
  end

  local cwd
  local has_oil, oil = pcall(require, "oil")
  if has_oil then
    cwd = oil.get_current_dir()
  end

  local task = require("overseer").new_task({
    cmd  = cmd,
    cwd  = cwd,
    name = "grep " .. args,
    components = {
      {
        "on_output_quickfix",
        errorformat = vim.o.grepformat,
        open        = not params.bang,
        open_height = 8,
        items_only  = true,
      },
      -- We don't care to keep this around as long as most tasks
      { "on_complete_dispose", timeout = 30 },
      "default",
    },
  })
  task:start()
end, { desc = "Run vimgrep ", nargs = "*", bang = true, bar = true, complete = "file" })

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
