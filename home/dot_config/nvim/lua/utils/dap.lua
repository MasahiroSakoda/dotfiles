-- -*-mode:lua-*- vim:ft=lua
local dap, widgets, dapui = require("dap"), require("dap.ui.widgets"), require("dapui")
local float_args = {
  enter    = true,
  width    = 130,
  height   = 40,
  position = "center",
}

local is_running = function() return string.len(dap.status()) > 0 end

vim.api.nvim_create_user_command("DapRunLast",     function() return is_running and dap.run_last() end, {})
vim.api.nvim_create_user_command("DapToggleUI",    function() dapui.toggle({ reset = true }) end, {})
vim.api.nvim_create_user_command("DapPreview",     function() widgets.preview() end, {})
vim.api.nvim_create_user_command("DapHover",       function() widgets.hover() end, {})
vim.api.nvim_create_user_command("DapFloatStacks", function() dapui.float_element("stacks",  float_args) end, {})
vim.api.nvim_create_user_command("DapFloatWatch",  function() dapui.float_element("watches", float_args) end, {})
vim.api.nvim_create_user_command("DapFloatScope",  function() dapui.float_element("scope",   float_args) end, {})
vim.api.nvim_create_user_command("DapLog", function()
  vim.cmd("vsplit" .. vim.fn.stdpath("cache") .. "/dap.log")
end, {})
