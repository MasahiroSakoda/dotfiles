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

local palette = require("onedark.palette")[vim.g.themestyle]
vim.api.nvim_set_hl(0, "FlashLabel",    { fg = "#b5ff17",    bold = true })
vim.api.nvim_set_hl(0, "FlashMatch",    { fg = palette.red,  bold = false })
vim.api.nvim_set_hl(0, "FlashCurrent",  { fg = palette.cyan, bold = true, underline = true })
vim.api.nvim_set_hl(0, "FlashBackdrop", { link = "Comment" })
