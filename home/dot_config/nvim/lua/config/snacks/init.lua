---@class snacks.config
require("snacks").setup({
  bigfile      = require("config.snacks.bigfile"),
  quickfile    = require("config.snacks.quickfile"),
  scratch      = require("config.snacks.scratch"),
  indent       = require("config.snacks.indent"),
  scope        = require("config.snacks.scope"),
  toggle       = require("config.snacks.toggle"),
  dashboard    = require("config.snacks.dashboard"),
  dim          = require("config.snacks.dim"),
  input        = require("config.snacks.input"),
  image        = require("config.snacks.image"),
  explorer     = require("config.snacks.explorer"),
  picker       = require("config.snacks.picker"),
  gh           = require("config.snacks.gh"),
  notifier     = require("config.snacks.notifier"),
  scroll       = require("config.snacks.scroll"),
  terminal     = require("config.snacks.terminal"),
  zen          = require("config.snacks.zen"),
  statuscolumn = require("config.snacks.statuscolumn"),
  words        = require("config.snacks.words"),
  styles       = {
    notification = {
      relative = "editor",
      wo = { wrap = true }, -- Wrap notifications
    },
  }
})
