-- -*-mode:lua-*- vim:ft=lua
local M = {}
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

M.toggle_ui     = function() dapui.toggle({ reset = true }) end
M.float_watches = wrap(function() dapui.float_element("watches", float_args) end)
M.float_scopes  = wrap(function() dapui.float_element("scope",   float_args) end)
M.float_stacks  = wrap(function() dapui.float_element("stacks",  float_args) end)
M.hover         = wrap(function() widgets.hover() end)
M.preview       = wrap(function() widgets.preview() end)
M.open_log      = function() vim.cmd("vsplit " .. vim.fn.stdpath("cache") .. "/dap.log") end

return M
