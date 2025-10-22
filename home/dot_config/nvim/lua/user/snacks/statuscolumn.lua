-- -*-mode:lua-*- vim:ft=lua

---@type snacks.statuscolumn.Config
return {
  enabled     = true,
  left  = { "mark", "sign" },
  right = { "fold", "git" },
}
