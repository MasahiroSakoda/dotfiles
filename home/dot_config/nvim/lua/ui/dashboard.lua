-- -*-mode:lua-*- vim:ft=lua

---@class snacks.dashboard.Config
return {
  row = nil, -- dashboard position. nil for center
  col = nil, -- dashboard position. nil for center
  pane_gap = 4, -- empty columns between vertical panes
  autokeys = "1234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ", -- autokey sequence

  preset = {
    ---@type fun(cmd:string, opts:table)|nil
    pick = nil,
    -- Used by the `keys` section to show keymaps.
    -- Set your curstom keymaps here.
    -- When using a function, the `items` argument are the default keymaps.
    ---@type snacks.dashboard.Item[]
    keys = {
      { icon = " ", key = "n", desc = "New File",      action = ":ene | startinsert" },
      { icon = " ", key = "f", desc = "Frecency File", action = ":Telescope frecency" },
      { icon = " ", key = "g", desc = "Grep Search",   action = ":Telescope egrepify" },
      { icon = " ", key = "F", desc = "Find File",     action = ":lua Snacks.dashboard.pick('files')" },
      { icon = " ", key = "h", desc = "History",       action = ":lua Snacks.dashboard.pick('oldfiles')" },
      { icon = "󱀸 ", key = "s", desc = "Session",       section = "session" },
      { icon = " ", key = "q", desc = "Quit",          action = ":qa" },
    },
        -- Used by the `header` section
    header = [[
.    .####          ((\                                                                                 .
.  /((((###         (((((                                                                               .
. //*((((((((       ((((((       ██████   █████                   █████   █████  ███                    .
. ////*((((((((     ((((((      ░░██████ ░░███                   ░░███   ░░███  ░░░                     .
. //////((((((((    //////       ░███░███ ░███   ██████   ██████  ░███    ░███  ████  █████████████     .
. //////  ((((((((  //////       ░███░░███░███  ███░░███ ███░░███ ░███    ░███ ░░███ ░░███░░███░░███    .
. ******    ((((((((//////       ░███ ░░██████ ░███████ ░███ ░███ ░░███   ███   ░███  ░███ ░███ ░███    .
. ******     (((((((//////       ░███  ░░█████ ░███░░░  ░███ ░███  ░░░█████░    ░███  ░███ ░███ ░███    .
. ******       ///////////       █████  ░░█████░░██████ ░░██████     ░░███      █████ █████░███ █████   .
.  *****         ///////*       ░░░░░    ░░░░░  ░░░░░░   ░░░░░░       ░░░      ░░░░░ ░░░░░ ░░░ ░░░░░    .
.    ***          ////                                                                                  .
]],
  },

  sections = {
    { section = 'header' },
    { icon = " ", title = "Keymaps",      section = "keys",         indent = 2, padding = 1 },
    { icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
    { icon = " ", title = "Projects",     section = "projects",     indent = 2, padding = 1 },
    { section = "startup" },
  },
}
