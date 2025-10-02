-- -*-mode:lua-*- vim:ft=lua
local ok, sidekick = pcall(require, "sidekick")
if not ok then return end

sidekick.setup({
  nes = { debounce = 500 },
  cli = {
    watch = true,
  },
})
