-- -*-mode:lua-*- vim:ft=lua

---@class snacks.scroll.Config
return {
  enabled = false,

  animate = {
    duration = { step = 5, total = 250 },
    easing   = "inQuad",
  },
  animate_repeat = {
    delay = 100,
    duration = { step = 5, total = 50 },
    easing   = "inQuad",
  },

  filter = function(buf)
    return vim.g.snacks_scroll ~= false and vim.b[buf].snacks_scroll ~= false and vim.bo[buf].buftype ~= "terminal"
  end,
}
