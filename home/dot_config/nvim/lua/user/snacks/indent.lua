-- -*-mode:lua-*- vim:ft=lua

---@class snacks.indent.Config
---@field enabled boolean
return {
  enabled = true,

  indent = {
    enable       = true,
    priority     = 200,
    only_scope   = true,
    only_current = false,
    hl = {
      "SnacksIndent1",
      "SnacksIndent2",
      "SnacksIndent3",
      "SnacksIndent4",
      "SnacksIndent5",
      "SnacksIndent6",
      "SnacksIndent7",
      "SnacksIndent8",
    },  ---@type string|string[] hl group for indent guides
  },

  scope = {
    enabled      = true,
    priority     = 200,
    underline    = true,
    only_current = false,
    hl = {
      "SnacksIndent1",
      "SnacksIndent2",
      "SnacksIndent3",
      "SnacksIndent4",
      "SnacksIndent5",
      "SnacksIndent6",
      "SnacksIndent7",
      "SnacksIndent8",
    },  ---@type string|string[] hl group for scopes
  },
}
