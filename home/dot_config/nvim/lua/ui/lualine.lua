local lualine_ok, lualine   = pcall(require, "lualine")
local navic_ok,   navic     = pcall(require, "nvim-navic")
local overseer_ok, overseer = pcall(require, "overseer")
if not (lualine_ok or navic_ok or overseer_ok) then return end

local ignore = require("core.ignore")

lualine.setup {
  options = {
    icons_enabled = true,
    -- Usable Themes: molokai / ayu_mirage / dracula / horizon / solarized_dark
    -- https://github.com/nvim-lualine/lualine.nvim/blob/master/THEMES.md
    theme = require("lualine.themes.onedark"),
    -- Separator
    component_separators = { left = "", right = "" },
    section_separators   = { left = "", right = "" },
    disabled_filetypes = {
      statusline = ignore.lualine.statusline,
      winbar = ignore.lualine.winbar,
    },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = true,
    refresh = { statusline = 1000, tabline = 1000, winbar = 1000 },
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = {
      { "branch" },
      { "diff" },
      { "diagnostics" },
    },
    lualine_c = {
      {
        "filename",
        icon = "",
        path = 4, -- 0: Filename, 1: Relative, 2: Absolute, 3: Absolute+ w/ home dir 4: Filename + Parent dir
        symbols = { modified = "", readonly = "", newfile  = "", unnamed  = "" }
      },
    },
    lualine_x = {
      {
        function() return navic.get_location() end,
        cond = function() return navic.is_available() and vim.g.navic_enabled end,
      },
      {
        "overseer",
        label = "",     -- Prefix for task counts
        colored = true, -- Color the task icons and counts
        symbols = {
          [overseer.STATUS.FAILURE]  = " :",
          [overseer.STATUS.CANCELED] = " :",
          [overseer.STATUS.SUCCESS]  = " :",
          [overseer.STATUS.RUNNING]  = " :",
        },
        unique     = false, -- Unique-ify non-running task count by name
        name       = nil,   -- List of task names to search for
        name_not   = false, -- When true, invert the name search
        status     = nil,   -- List of task statuses to display
        status_not = false, -- When true, invert the status search
      }
    },
    lualine_y = { "fileformat", "encoding" },
    lualine_z = { "location", "progress" },
  },
  tabline = {},
  winbar  = {},
  extensions = {
    "quickfix",
    "overseer",
    "trouble",
    "oil",
    "fzf",
    "mason",
  },
}
