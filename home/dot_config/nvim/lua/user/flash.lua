-- -*-mode:lua-*- vim:ft=lua
local ok, flash = pcall(require, "flash")
if not ok then return end

---@type Flash.Config
flash.setup({
  labels = "hjklasdfgyuiopqwertnmzxcvb",
  search = { multi_window = true },
  jump   = { autojump = true },
  label  = { uppercase = false, rainbow = { enabled = false } },

  highlight = {
    groups = {
      match    = "FlashMatch",
      current  = "FlashCurrent",
      backdrop = "FlashBackdrop",
      label    = "FlashLabel",
    },
  },
  pattern   = "",
  continue  = false,

  modes = {
    char = { autohide = true, jump_labels = true },
    treesiter = { labels = "hjklasdfgyuiopqwertnmzxcvb" },
  },
  prompt = {},
  remote_op = {},
  exclude = require("core.ignore").flash,
})
