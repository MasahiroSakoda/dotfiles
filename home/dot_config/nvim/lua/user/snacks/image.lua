-- -*-mode:lua-*- vim:ft=lua
local ft = require("user.filetypes")

---@class snacks.image.Config
return {
  enabled = function()
    return vim.tbl_contains(ft.snacks.image.triggers, vim.bo.filetype)
  end,
  formats = ft.snacks.image.formats,
  force   = false,
}
