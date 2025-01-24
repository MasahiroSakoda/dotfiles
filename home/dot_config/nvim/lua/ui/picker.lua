-- -*-mode:lua-*- vim:ft=lua

---@class snacks.picker.Config
return {
  enabled = true,
  prompt = " ",

  matcher = {
    cwd_bonus = true,
    frecency  = true,
  },
}
