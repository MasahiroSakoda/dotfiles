-- -*-mode:lua-*- vim:ft=lua

---@type snacks.words.Config
return {
  enabled     = true,
  debounce    = 200,
  notify_jump = false,
  notify_end  = true,
  foldopen    = true,
  jumplist    = true,
  modes       = { "n", "i", "c" },
}
