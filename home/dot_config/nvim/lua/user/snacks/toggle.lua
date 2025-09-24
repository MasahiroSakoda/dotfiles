-- -*-mode:lua-*- vim:ft=lua

---@class snacks.toggle.Config
return {
  enabled = true,

  map       = vim.keymap.set,
  which_key = true,
  notify    = true,
  icon  = { enabled  = " ",    disabled = " " },
  color = { enabled  = "green", disabled = "yellow" },
}
