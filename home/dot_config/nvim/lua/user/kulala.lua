-- -*-mode:lua-*- vim:ft=lua
local ok, kulala = pcall(require, "kulala")
if not ok then return end

kulala.setup({
  debug          = false,
  global_keymaps = false,
  winbar         = true,
  treesitter     = true,
  display_mode   = "float",
  default_view   = "header_body",

  ui = {
    win_opts = { wo = { foldmethod = "manual" } },
  },
})
