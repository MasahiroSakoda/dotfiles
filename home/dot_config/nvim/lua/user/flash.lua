-- -*-mode:lua-*- vim:ft=lua
local ok, flash = pcall(require, "flash")
if not ok then return end

flash.setup({
  labels = "asdfghjklqwertyuiopzxcvbnm",
  search = {
    -- search/jump in all windows
    multi_window = false,
  },
  exclude = {
    "flash_prompt",
    "notify",
    "noice",
    "neo-tree",
    "cmp_menu",
  },
})
