-- -*-mode:lua-*- vim:ft=lua
local scope = require("snacks.scope")

---@type snacks.scope.Config
return {
  enabled  = true,
  max_size = 20,
  cursor   = true,

  treesitter = {
    enabled = true,
  },
}
