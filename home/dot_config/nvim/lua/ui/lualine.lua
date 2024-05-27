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
    lualine_a = {
      { "mode", icon = { "", color = { fg = "#0f0f0f" } } },
    },
    lualine_b = { "branch", "diff" },
    lualine_c = {
      { "diagnostics", source = { "nvim-lsp", "nvim_diagnostic"} },
      {
        "filename",
        icon = { "", color = { fg = "#FFFFFF" } },
        path = 1, --- @type 0|1|2|3|4
        symbols = { modified = "", readonly = "", newfile  = "", unnamed  = "" }
      },
    },
    lualine_x = {
      {
        -- TODO: Confirugre `overseer.nvim` detail options
        "overseer",
      },
    },
    lualine_y = { "encoding", "fileformat" },
    lualine_z = { "progress", "location" },
  },
  winbar = {
    lualine_c = {
      {
        function() return navic.get_location() end,
        cond = function() return navic.is_available() end,
      },
    },
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
