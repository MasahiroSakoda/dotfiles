-- -*-mode:lua-*- vim:ft=lua

vim.api.nvim_create_user_command("GitBlameLine", function()
  require("snacks").git.blame_line()
end, {})
