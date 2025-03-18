-- -*-mode:lua-*- vim:ft=lua
local ok, snacks = pcall(require, "snacks")
if not ok then return end

---@class snacks.config
snacks.setup({
  bigfile      = require("user.bigfile"),
  quickfile    = require("user.quickfile"),
  indent       = require("user.indent"),
  toggle       = require("user.toggle"),
  dashboard    = require("ui.dashboard"),
  dim          = require("ui.dim"),
  input        = require("ui.input"),
  image        = require("ui.image"),
  explorer     = require("ui.explorer"),
  picker       = require("ui.picker"),
  notifier     = require("ui.notifier"),
  terminal     = require("ui.terminal"),
  zen          = require("ui.zen"),
  statuscolumn = { enabled = true },
  words        = { enabled = false },
  styles       = {
    notification = {
      relative = "editor",
      wo = { wrap = true }, -- Wrap notifications
    },
  }
})

vim.api.nvim_create_user_command("SnacksPickerLazyPlugin", function()
  require("snacks.picker").smart({ cwd = vim.fn.stdpath("data") .. "/lazy" })
end, { desc = "", nargs = "*", bang = true })
