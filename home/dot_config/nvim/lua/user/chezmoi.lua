-- -*-mode:lua-*- vim:ft=lua
local ok, chezmoi = pcall(require, "chezmoi")
if not ok then return end

chezmoi.setup({
  edit = {
    watch = false,
    force = false,
  },
  notification = {
    on_open  = true, -- notify file opened
    on_apply = true, -- notify `chezmoi apply` after file saved
    on_watch = false,
  },
  telescope = {
    select = { "<CR>" },
  },
})
