-- -*-mode:lua-*- vim:ft=lua

---@class snacks.zen.Config
return {
  enabled = true,
  toggles = {
    dim             = false,
    git_signs       = true,
    mini_diff_signs = false,
  },
  show = {
    statusline = false,
    tabline    = false,
  },

  win = {
    style = "zen",
    width = 0.6,
  },

  on_open  = function(_) end,
  on_close = function(_) end,

  zoom = {
    toggles = {},
    show = { statusline = true, tabline = true },
    win = {
      backdrop = false,
      width = 0, -- 0: full width
    },
  },
}
