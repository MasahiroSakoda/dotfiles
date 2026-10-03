---@type Flash.Config
require("flash").setup({
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
    char = { autohide = true, jump_labels = false },
    treesitter = { labels = "hjklasdfgyuiopqwertnmzxcvb" },
  },
  prompt = {},
  remote_op = {},
  exclude = require("config.core.ignore").flash,
})


vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function()
    local palette = require("onedark.palette")[vim.g.themestyle]
    vim.api.nvim_set_hl(0, "FlashLabel",    { fg = "#b5ff17", bold = true })
    vim.api.nvim_set_hl(0, "FlashMatch",    { link = "SnacksPickerMatch" })
    vim.api.nvim_set_hl(0, "FlashCurrent",  { fg = palette.cyan, bold = true, underline = true })
    vim.api.nvim_set_hl(0, "FlashBackdrop", { link = "Comment" })
  end
})
