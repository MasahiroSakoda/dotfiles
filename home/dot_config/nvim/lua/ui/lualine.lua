local lualine_ok, lualine = pcall(require, "lualine")
local navic_ok,   navic   = pcall(require, "nvim-navic")
if not (lualine_ok or navic_ok) then return end

lualine.setup {
  options = {
    icons_enabled = true,
    -- Usable Themes: dracula / horizon / molokai / solarized_dark
    theme = require("lualine.themes.molokai"),
    -- Separator
    component_separators = { left = "", right = "" },
    section_separators   = { left = "", right = "" },
    disabled_filetypes = {
      "alpha",
      "dashboard",
      "lspsagaoutline",
      -- "neo-tree",
      "Trouble",
      "navic",
      "dapui_breakpoints",
      "dapui_console",
      "dap-repl",
      "dapui_scopes",
      "dapui_stacks",
      "dapui_watches",
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
    lualine_a = { { "mode", icon = { "", color = { fg = "#000000" } } } },
    lualine_b = { "branch", "diff" },
    lualine_c = {
      { "filename", path = 1, icon = { "", color = { fg = "#FFFFFF" } } },
      -- { "diagnostics", source = "nvim-lsp" },
      { function() return navic.get_location() end, cond = function() return navic.is_available() end },
    },
    lualine_x = { "encoding", "fileformat", "filetype" },
    lualine_y = { { "progress", icon = { "", color = { fg = "#FFFFFF" } } } },
    lualine_z = { { "location", icon = { "", color = { fg = "#000000" } } } },
  },
  extensions = {
    "quickfix",
    "trouble",
    "neo-tree",
    "fzf",
  },
}
