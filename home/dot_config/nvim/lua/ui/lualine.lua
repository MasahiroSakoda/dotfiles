local lualine_ok, lualine = pcall(require, "lualine")
local navic_ok,   navic   = pcall(require, "nvim-navic")
if not (lualine_ok or navic_ok) then return end

lualine.setup {
  options = {
    icons_enabled = true,
    -- Usable Themes: molokai / ayu_mirage / dracula / horizon / solarized_dark
    theme = require("lualine.themes.dracula"),
    -- Separator
    component_separators = { left = "", right = "" },
    section_separators   = { left = "", right = "" },
    disabled_filetypes = {
      statusline = {
        "alpha",
        "dashboard",
        "lazy",
        "lspsagaoutline",
        "navic",
        "neo-tree",
        "Trouble",
      },
      winbar = {
        "dapui_breakpoints",
        "dapui_console",
        "dap-repl",
        "dapui_scopes",
        "dapui_stacks",
        "dapui_watches",
        "alpha",
        "dashboard",
      },
    },
    ignore_focus = { "toggleterm" },
    always_divide_middle = true,
    globalstatus = true,
    refresh = {
      statusline = 1000,
      tabline    = 1000,
      winbar     = 1000,
    }
  },
  sections = {
    lualine_a = {
      { "mode", icon = { "", color = { fg = "#000000" } } },
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
        function() return navic.get_location() end,
        cond = function() return navic.is_available() end,
      },
    },
    lualine_y = { "encoding", "fileformat" },
    lualine_z = { "progress", "location" },
  },
  extensions = {
    "quickfix",
    "trouble",
    "neo-tree",
    "fzf",
    "mason",
  },
}
