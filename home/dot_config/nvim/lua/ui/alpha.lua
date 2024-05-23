local ok, alpha = pcall(require, "alpha")
if not ok then return end

local dashboard = require("alpha.themes.dashboard")
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
  dashboard.button("f", "    Frecency Search", "<CMD>Telescope frecency<CR>"),
  dashboard.button("F", "    Find files",      "<CMD>Telescope find_files<CR>"),
  dashboard.button("r", "    Recent files",    "<CMD>Telescope oldfiles only_cwd=true<CR>"),
  dashboard.button("g", "    Grep search",     "<CMD>Telescope egrepify<CR>"),
  dashboard.button("G", "    Find word",       "<CMD>Telescope grep_string<CR>"),
  -- dashboard.button("p", "    Find project",    "<CMD>lua require('telescope').extensions.projects.projects()<CR>"),
  dashboard.button("q", "    Quit NVIM",       "<CMD>qa<CR>"),
}
for _, button in ipairs(dashboard.section.buttons.val) do
  button.opts.hl = "AlphaButtons"
  button.opts.hl_shortcut = "AlphaShortcut"
end

local dashboard_height = function()
  local banner_height, btn_count = 0, 0
  for _ in ipairs(dashboard.section.header.val) do banner_height = banner_height + 1 end
  for _ in ipairs(dashboard.section.buttons.val) do btn_count = btn_count + 1 end
  local btn_height, footer_height = 2 * btn_count, 1
  return banner_height + dashboard.opts.layout[3].val + btn_height + footer_height
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

dashboard.section.buttons.opts.hl = "AlphaButtons"
dashboard.section.footer.opts.hl  = "Type"
-- dashboard.section.footer.opts.hl  = "Constant"

local topSpace = vim.fn.max { 0, vim.fn.floor((vim.fn.winheight(0) - dashboard_height()) / 4) }
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
