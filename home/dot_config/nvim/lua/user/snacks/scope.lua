-- -*-mode:lua-*- vim:ft=lua
local scope = require("snacks.scope")

require("which-key").add({
  mode = { "n", "x", "o" },
  { "[i", function() scope.jump({ min_size = 1, bottom = false }) end, icon = " ", desc = "Scope Top" },
  { "]i", function() scope.jump({ min_size = 1, bottom = true })  end, icon = " ", desc = "Scope Bottom" },
})

---@type snacks.scope.Config
return {
  enabled  = true,
  max_size = 20,
  cursor   = true,

  treesitter = {
    enabled = true,
  },
}
