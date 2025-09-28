-- -*-mode:lua-*- vim:ft=lua
local ok, flash = pcall(require, "flash")
if not ok then return end

---@type Flash.Config
flash.setup({
  labels = "hjklasdfgyuiopqwertnmzxcvb",
  search = { multi_window = true },
  jump   = { autojump = true },
  label  = { uppercase = false, rainbow = { enabled = false } },

  highlight = {},
  pattern   = "",
  continue  = false,

  modes = {
    char = { jump_labels = true },
  },
  prompt = {},
  remote_op = {},
  exclude = require("core.ignore").flash,
})

vim.api.nvim_create_user_command("FlashJumpWord", function(_)
  require("flash").jump({ modes = { char = { jump_labels = true } } })
end, { desc = "Jump to the word", nargs = "*", bang = true })

vim.api.nvim_create_user_command("FlashJumpLine", function(_)
  require("flash").jump({ pattern = "^", search  = { mode = "search" }, label   = { after = { 0, 0 } } })
end, { desc = "Jump to the line", nargs = "*", bang = true })
