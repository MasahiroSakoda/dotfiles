-- -*-mode:lua-*- vim:ft=lua

-- flash.nvim hilights
vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function()
    local palette = require("onedark.palette")[vim.g.themestyle]
    vim.api.nvim_set_hl(0, "FlashLabel",    { fg = "#b5ff17", bold = true })
    vim.api.nvim_set_hl(0, "FlashMatch",    { link = "SnacksPickerMatch" })
    vim.api.nvim_set_hl(0, "FlashCurrent",  { fg = palette.cyan, bold = true, underline = true })
    vim.api.nvim_set_hl(0, "FlashBackdrop", { link = "Comment" })
  end
})
