-- -*-mode:lua-*- vim:ft=lua
local ok, octo = pcall(require, "octo")
if not ok then return end

local palette = require("onedark.palette")[vim.g.themestyle]

octo.setup({
  default_remote         = { "upstream", "origin" },
  default_merge_method   = "commit",
  default_delete_branch  = true,
  suppress_missing_scope = { project_v2 = true },

  ssh_aliases = {}, -- SSH aliases. e.g. `ssh_aliases = {["github.com-work"] = "github.com"}`
  gh_env      = {},
  timeout     = 5000,

  ui = {
    use_signcolumn = true,
    use_signstatus = true,
  },

  picker = "snacks",
  picker_config = {
    open_in_browser = { lhs = "<C-b>", desc = "Open issue in browser" },
    copy_url        = { lhs = "<C-y>", desc = "Copy url to system clipboard" },
    checkout_pr     = { lhs = "<C-o>", desc = "Checkout pull request" },
    merge_pr        = { lhs = "<C-r>", desc = "Merge pull request" },
  },

  colors = {
    white       = palette.fg,
    gray        = palette.gray,
    black       = palette.black,
    red         = palette.red,
    dark_red    = palette.dark_red,
    green       = palette.green,
    dark_green  = palette.dark_green,
    yellow      = palette.yellow,
    dark_yellow = palette.dark_yellow,
    blue        = palette.blue,
    dark_blue   = palette.dark_blue,
    purple      = palette.purple
  },

  mappings_disable_default = false,
  mappings = {
    notification = {
      read = { lhs = "<localleader>rn", desc = "Mark notification as read" },
    },
  },
})
