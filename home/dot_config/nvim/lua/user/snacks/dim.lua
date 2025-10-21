-- -*-mode:lua-*- vim:ft=lua

---@class snacks.dim.Config
return {
  enabled = true,

  scope = {
    min_size = 5,
    max_size = 20,
    siblings = true,
    cursor   = true,
    edge     = true,
    filter   = function(buf) return vim.bo[buf].buftype == "" end,
    debounce = 30,

    treesitter = {},
    keys = {},
  },
}
