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
  gh           = require("user.snacks.gh"),
  notifier     = require("user.snacks.notifier"),
  scroll       = require("user.snacks.scroll"),
  terminal     = require("user.snacks.terminal"),
  zen          = require("user.snacks.zen"),
  statuscolumn = require("user.snacks.statuscolumn"),
  words        = require("user.snacks.words"),
  styles       = {
    notification = {
      relative = "editor",
      wo = { wrap = true }, -- Wrap notifications
    },
  }
})
