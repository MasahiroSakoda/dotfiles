-- -*-mode:lua-*- vim:ft=lua
local ok, snacks = pcall(require, "snacks")
if not ok then return end

---@class snacks.config
snacks.setup({
  bigfile      = require("user.snacks.bigfile"),
  quickfile    = require("user.snacks.quickfile"),
  scratch      = require("user.snacks.scratch"),
  indent       = require("user.snacks.indent"),
  scope        = require("user.snacks.scope"),
  toggle       = require("user.snacks.toggle"),
  dashboard    = require("user.snacks.dashboard"),
  dim          = require("user.snacks.dim"),
  input        = require("user.snacks.input"),
  image        = require("user.snacks.image"),
  explorer     = require("user.snacks.explorer"),
  picker       = require("user.snacks.picker"),
  notifier     = require("user.snacks.notifier"),
  terminal     = require("user.snacks.terminal"),
  zen          = require("user.snacks.zen"),
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
