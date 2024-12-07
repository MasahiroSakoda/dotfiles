-- -*-mode:lua-*- vim:ft=lua
local builtin = require("telescope.builtin")

vim.api.nvim_create_user_command("TelescopeSearchCword", function()
  builtin.grep_string({ search = vim.fn.expand("<cword>")})
end, {})

vim.api.nvim_create_user_command("TelescopeSearchCWORD", function()
  builtin.grep_string({ search = vim.fn.expand("<cWORD>")})
end, {})
