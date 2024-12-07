-- -*-mode:lua-*- vim:ft=lua
local telescope, builtin = require("telescope"), require("telescope.builtin")

vim.api.nvim_create_user_command("TelescopeSearchCword", function()
  builtin.grep_string({ search = vim.fn.expand("<cword>")})
end, {})

vim.api.nvim_create_user_command("TelescopeSearchCWORD", function()
  builtin.grep_string({ search = vim.fn.expand("<cWORD>")})
end, {})

local dap, chezmoi = telescope.extensions.dap, telescope.extensions.chezmoi
vim.api.nvim_create_user_command("TelescopeDapCommands",    function() dap.commands()         end, {})
vim.api.nvim_create_user_command("TelescopeDapConfig",      function() dap.configurations()   end, {})
vim.api.nvim_create_user_command("TelescopeDapFrames",      function() dap.commands()         end, {})
vim.api.nvim_create_user_command("TelescopeDapBreakpoints", function() dap.list_breakpoints() end, {})
vim.api.nvim_create_user_command("TelescopeDapVariables",   function() dap.variables()        end, {})
vim.api.nvim_create_user_command("TelescopeChezmoiFind",    function() chezmoi.find_files()   end, {})
