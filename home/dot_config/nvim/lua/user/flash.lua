-- -*-mode:lua-*- vim:ft=lua
local ok, flash = pcall(require, "flash")
if not ok then return end

flash.setup({
  labels = "hjklasdfgyuiopqwertnmzxcvb",
  search = {
    -- search/jump in all windows
    multi_window = false,
  },
  jump = {},
  label = {},
  highlight = {},
  pattern  = "",
  continue = false,

  modes = {},
  prompt = {},
  remote_op = {},
  exclude = require("core.ignore").flash,
})
