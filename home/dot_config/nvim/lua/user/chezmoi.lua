-- -*-mode:lua-*- vim:ft=lua
local ok, chezmoi = pcall(require, "chezmoi")
if not ok then return end

chezmoi.setup({
  edit = {
    watch = false,
    force = false,
  },
  notification = {
    on_open  = true,
    on_apply = true,
    on_watch = false,
  },
  telescope = {
    select = { "<CR>" },
  },
})
