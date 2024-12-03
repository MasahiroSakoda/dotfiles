-- -*-mode:lua-*- vim:ft=lua
local Terminal = require("toggleterm.terminal").Terminal

vim.api.nvim_create_user_command("ToggleLazygit", function()
  Terminal:new({
    cmd = "lazygit",
    hidden = true,
    direction = "float", ---@type "float"|"vertical"|"horizontal"|"tab"
  }):toggle()
end, {})

vim.api.nvim_create_user_command("ToggleGitHubDash", function()
  Terminal:new({
    cmd = "gh dash",
    hidden = true,
    direction = "float", ---@type "float"|"vertical"|"horizontal"|"tab"
  }):toggle()
end, {})

vim.api.nvim_create_user_command("ToggleBottom", function()
  Terminal:new({
    cmd = "btm",
    hidden = true,
    direction = "float", ---@type "float"|"vertical"|"horizontal"|"tab"
  }):toggle()
end, {})
