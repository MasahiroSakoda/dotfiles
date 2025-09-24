-- -*-mode:lua-*- vim:ft=lua
local ok, autotag = pcall(require, "nvim-ts-autotag")
if not ok then return end

autotag.setup({
  opts = {
    enable_close          = true,
    enable_rename         = true,
    enable_close_on_slash = false,
  },
})
