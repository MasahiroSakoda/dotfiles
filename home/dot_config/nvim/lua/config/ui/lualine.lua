require("lualine").setup({
  options = {
    theme = require("lualine.themes.onedark"),
    icons_enabled = true,

    component_separators = { left = "", right = "" },
    section_separators   = { left = "", right = "" },

    always_divide_middle = true,
    globalstatus         = true,

    refresh = { statusline = 500, tabline = 1000, winbar = 1000 },
  },

  sections = {
    lualine_a = { "mode" },
    lualine_b = { "branch", "diff" },
    lualine_c = {},
    lualine_x = {},
    lualine_y = { "fileformat", "encoding", "filetype" },
    lualine_z = { "location", "progress" },
  },
  tabline = {},
  winbar  = {},

  extensions = { "quickfix", "oil", "trouble" },
})
