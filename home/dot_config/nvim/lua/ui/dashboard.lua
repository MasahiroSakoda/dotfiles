-- -*-mode:lua-*- vim:ft=lua

return {
  row = nil, -- dashboard position. nil for center
  col = nil, -- dashboard position. nil for center
  pane_gap = 4, -- empty columns between vertical panes

  preset = {
    pick = nil,
    -- Used by the `keys` section to show keymaps.
    -- Set your curstom keymaps here.
    -- When using a function, the `items` argument are the default keymaps.
    keys = {
      { icon = " ", key = "n", desc = "[N]ew File",      action = ":ene | startinsert" },
      { icon = " ", key = "f", desc = "[F]recency File", action = ":Telescope frecency" },
      { icon = " ", key = "g", desc = "[G]rep Search",   action = ":Telescope egrepify" },
      { icon = " ", key = "F", desc = "[F]ind File",     action = ":lua Snacks.dashboard.pick('files')" },
      { icon = " ", key = "h", desc = "[H]istory",       action = ":lua Snacks.dashboard.pick('oldfiles')" },
      { icon = "󱀸 ", key = "s", desc = "[S]ession",       section = "session" },
      { icon = " ", key = "q", desc = "[Q]uit",          action = ":qa" },
    },
        -- Used by the `header` section
    header = [[
┌───────────────────────────────────────────────────────────────────────────────────────────────────────┐
│    .####          ((\                                                                                 │
│  /((((###         (((((                                                                               │
│ //*((((((((       ((((((       ██████   █████                   █████   █████  ███                    │
│ ////*((((((((     ((((((      ░░██████ ░░███                   ░░███   ░░███  ░░░                     │
│ //////((((((((    //////       ░███░███ ░███   ██████   ██████  ░███    ░███  ████  █████████████     │
│ //////  ((((((((  //////       ░███░░███░███  ███░░███ ███░░███ ░███    ░███ ░░███ ░░███░░███░░███    │
│ ******    ((((((((//////       ░███ ░░██████ ░███████ ░███ ░███ ░░███   ███   ░███  ░███ ░███ ░███    │
│ ******     (((((((//////       ░███  ░░█████ ░███░░░  ░███ ░███  ░░░█████░    ░███  ░███ ░███ ░███    │
│ ******       ///////////       █████  ░░█████░░██████ ░░██████     ░░███      █████ █████░███ █████   │
│  *****         ///////*       ░░░░░    ░░░░░  ░░░░░░   ░░░░░░       ░░░      ░░░░░ ░░░░░ ░░░ ░░░░░    │
│    ***          ////                                                                                  │
└───────────────────────────────────────────────────────────────────────────────────────────────────────┘
]],
  },

  sections = {
    { section = "header", },
    { section = "keys", gap = 1, indent = 2, padding = 0 },
    { icon = " ", title = "Recent Files", section = "recent_files", indent = 2, gap = 0, padding = { 0, 1 } },
    { icon = " ", title = "Projects",     section = "projects",     indent = 2, gap = 0, padding = { 0, 1 } },
    { section = "startup", padding = { 0, 1 } },
  },
}
