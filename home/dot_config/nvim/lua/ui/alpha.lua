local ok, alpha = pcall(require, "alpha")
if not ok then return end

local dashboard = require("alpha.themes.dashboard")
local function getDashboardHeight()
  local bannerHeight = 0
  for _ in pairs(dashboard.section.header.val) do bannerHeight = bannerHeight + 1 end
  local buttonCount = 0
  for _ in pairs(dashboard.section.buttons.val) do buttonCount = buttonCount + 1 end
  local buttonsHeight = 2 * buttonCount
  local footerHeight = 1
  local dashboardHeight = bannerHeight + dashboard.opts.layout[3].val + buttonsHeight + footerHeight
  return dashboardHeight
end

-- Header
dashboard.section.header.opts.hl = "AlphaHeader"
-- dashboard.section.header.val = {
-- 	" ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗",
-- 	" ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║",
-- 	" ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║",
-- 	" ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║",
-- 	" ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║",
-- 	" ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝",
-- 	"",
-- 	"",
-- 	"",
-- }

dashboard.section.header.val = {
  [[                                                                                                     ]],
  [[    ,####          ((                                                                                ]],
  [[  /((((###         (((((                                                                             ]],
  [[ //*((((((((       ((((((       ██████   █████                   █████   █████  ███                  ]],
  [[ ////*((((((((     ((((((      ░░██████ ░░███                   ░░███   ░░███  ░░░                   ]],
  [[ //////((((((((    //////       ░███░███ ░███   ██████   ██████  ░███    ░███  ████  █████████████   ]],
  [[ //////  ((((((((  //////       ░███░░███░███  ███░░███ ███░░███ ░███    ░███ ░░███ ░░███░░███░░███  ]],
  [[ ******    ((((((((//////       ░███ ░░██████ ░███████ ░███ ░███ ░░███   ███   ░███  ░███ ░███ ░███  ]],
  [[ ******     (((((((//////       ░███  ░░█████ ░███░░░  ░███ ░███  ░░░█████░    ░███  ░███ ░███ ░███  ]],
  [[ ******       ///////////       █████  ░░█████░░██████ ░░██████     ░░███      █████ █████░███ █████ ]],
  [[  *****         ///////*       ░░░░░    ░░░░░  ░░░░░░   ░░░░░░       ░░░      ░░░░░ ░░░░░ ░░░ ░░░░░  ]],
  [[     **          ////                                                                                ]],
  [[                                                                                                     ]],
}

-- Buttons
dashboard.section.buttons.val = {
  dashboard.button("n", "    New file",        ":ene <BAR> startinsert <CR>"),
  dashboard.button("f", "    Frecency Search", ":Telescope frecency<CR>"),
  dashboard.button("F", "    Find files",      ":Telescope find_files<CR>"),
  dashboard.button("r", "    Recent files",    ":Telescope oldfiles only_cwd=true<CR>"),
  dashboard.button("g", "    Grep search",     ":Telescope live_grep<CR>"),
  dashboard.button("G", "    Find word",       ":Telescope grep_string<CR>"),
  -- dashboard.button("p", "    Find project",  ":lua require('telescope').extensions.projects.projects()<CR>"),
  dashboard.button("q", "    Quit NVIM",     ":qa<CR>"),
}
for _, button in ipairs(dashboard.section.buttons.val) do
  button.opts.hl = "AlphaButtons"
  button.opts.hl_shortcut = "AlphaShortcut"
end

dashboard.section.buttons.opts.hl = "AlphaButtons"
dashboard.section.footer.opts.hl  = "Type"
-- dashboard.section.footer.opts.hl  = "Constant"

local topSpace = vim.fn.max { 0, vim.fn.floor((vim.fn.winheight(0) - getDashboardHeight()) / 4) }
dashboard.opts.layout[1].val = topSpace

alpha.setup(dashboard.config)

vim.api.nvim_create_autocmd("User", {
  pattern = "LazyVimStarted",
  callback = function()
    local stats = require("lazy").stats()
    local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)

    -- local now = os.date "%d-%m-%Y %H:%M:%S"
    local version = "   v" .. vim.version().major .. "." .. vim.version().minor .. "." .. vim.version().patch
    local fortune = require "alpha.fortune"
    local quote = table.concat(fortune(), "\n")
    local plugins = "⚡Neovim loaded " .. stats.count .. " plugins in " .. ms .. "ms"
    local footer = "\n\n\t" .. version .. "\t" .. plugins .. "\n" .. quote
    dashboard.section.footer.val = footer
    pcall(vim.cmd.AlphaRedraw)
  end,
})
