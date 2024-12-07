-- -*-mode:lua-*- vim:ft=lua

local oil = require("oil")

vim.api.nvim_create_user_command("OilToggleHidden",    function() oil.toggle_hidden() end, {})
vim.api.nvim_create_user_command("OilToggleFloat",     function() oil.toggle_float() end, {})
vim.api.nvim_create_user_command("OilToggleFloatRoot", function() oil.toggle_float(vim.uv.cwd()) end, {})
vim.api.nvim_create_user_command("OilToggleFloatDir",  function(param) oil.toggle_float(param.args) end, {})
