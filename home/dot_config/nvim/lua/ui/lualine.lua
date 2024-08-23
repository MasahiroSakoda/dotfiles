local lualine_ok, lualine = pcall(require, "lualine")
local navic_ok,   navic   = pcall(require, "nvim-navic")
if not (lualine_ok or navic_ok) then return end

local ignore = require("core.ignore")

lualine.setup {
  options = {
    icons_enabled = true,
    -- Usable Themes: molokai / ayu_mirage / dracula / horizon / solarized_dark
    -- https://github.com/nvim-lualine/lualine.nvim/blob/master/THEMES.md
    theme = require("lualine.themes.material"),
    -- Separator
    component_separators = { left = "", right = "" },
    section_separators   = { left = "", right = "" },
    disabled_filetypes = {
      statusline = ignore.lualine.statusline,
      winbar = ignore.lualine.winbar,
    },
    ignore_focus = { "toggleterm" },
    always_divide_middle = true,
    globalstatus = true,
    refresh = { statusline = 1000, tabline = 1000, winbar = 1000 },
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = { "branch", "diff", "diagnostics" },
    lualine_c = {
      {
        "filename",
        icon = "",
        path = 1, -- 0: Filename, 1: Relative, 2: Absolute, 3: Absolute+ w/ home dir 4: Filename + Parent dir
        symbols = { modified = "", readonly = "", newfile  = "", unnamed  = "" }
      },
    },
    lualine_x = {
      {
        function() return navic.get_location() end,
        cond = function() return navic.is_available() end,
      },
    },
    lualine_y = { "overseer", "fileformat", "encoding" },
    lualine_z = { "progress", "location" },
  },
  extensions = {
    "quickfix",
    "overseer",
    "trouble",
    "neo-tree",
    "fzf",
    "mason",
  },
}
