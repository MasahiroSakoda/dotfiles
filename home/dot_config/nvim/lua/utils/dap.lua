-- -*-mode:lua-*- vim:ft=lua
local dap, widgets, dapui = require("dap"), require("dap.ui.widgets"), require("dapui")
local float_args = {
  enter    = true,
  width    = 130,
  height   = 40,
  position = "center",
}

local is_running = function() return string.len(dap.status()) > 0 end
local wrap = function(callback)
  return function()
    if not is_running() then return vim.notify('Dap session not running', vim.log.levels.WARN) end
    callback()
  end
end

vim.api.nvim_create_user_command("DapRunLast",     wrap(dap.run_last()), {})
vim.api.nvim_create_user_command("DapToggleUI",    wrap(dapui.toggle({ reset = true })), {})
vim.api.nvim_create_user_command("DapPreview",     wrap(widgets.preview()), {})
vim.api.nvim_create_user_command("DapHover",       wrap(widgets.hover()), {})
vim.api.nvim_create_user_command("DapFloatStacks", wrap(dapui.float_element("stacks",  float_args)), {})
vim.api.nvim_create_user_command("DapFloatWatch",  wrap(dapui.float_element("watches", float_args)), {})
vim.api.nvim_create_user_command("DapFloatScope",  wrap(dapui.float_element("scope",   float_args)), {})
vim.api.nvim_create_user_command("DapLog", function()
  vim.cmd("vsplit" .. vim.fn.stdpath("cache") .. "/dap.log")
end, {})
