-- -*-mode:lua-*- vim:ft=lua

---@class snacks.dashboard.Config
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
      { icon = " ", key = "r", desc = "[R]ecent Files",  action = ":lua Snacks.picker.recent()" },
      { icon = " ", key = "g", desc = "[G]rep Search",   action = ":lua Snacks.picker.grep()" },
      { icon = " ", key = "f", desc = "[F]ind File",     action = ":lua Snacks.picker.smart()" },
      { icon = " ", key = "h", desc = "[H]istory",       action = ":lua Snacks.dashboard.oldfiles()" },
      { icon = " ", key = "b", desc = "[B]rowse",        action = ":OilToggleFloatRoot" },
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
    { icon = " ", title = "Shortcuts",      section = "keys",         indent = 4, gap = 0, padding = 1 },
    { icon = " ", title = "Recent Files",   section = "recent_files", indent = 4, gap = 0, padding = 1 },
    { icon = " ", title = "Projects",       section = "projects",     indent = 4, gap = 0, padding = 1 },
    { icon = " ", title = "Resore Session", section = "session",      indent = 4, gap = 0, padding = 1 },
    { section = "startup", padding = 1 },
  },
}
