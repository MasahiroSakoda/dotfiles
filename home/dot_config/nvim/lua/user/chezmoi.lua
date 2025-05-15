-- -*-mode:lua-*- vim:ft=lua
local ok, chezmoi = pcall(require, "chezmoi")
if not ok then return end

chezmoi.setup({
  edit = {
    watch = false,
    force = false,
  },
  events = {
    on_open  = { enabled = true,  opts = {} },
    on_watch = { enabled = false, opts = {} },
    on_apply = { enabled = true,  opts = {} },
  },
  telescope = {
    select = { "<CR>" },
  },
})
