local telescope_ok, telescope = pcall(require, "telescope")
local actions_ok, actions = pcall(require, "telescope._extensions.file_browser.actions")
if not (telescope_ok or actions_ok) then return end

local find_command = require("core.find")
local db_root = vim.fn.stdpath("state")

telescope.setup({
  pickers = {
    file_browser = {
      hidden = true,
      files  = true,
      find_command = find_command,
    },
  },
  extensions = {
    file_browser = {
      layout_strategy  = "horizontal",
      hijack_netrw = true,
      -- Keymap
      mappings = {
        ["n"] = {
          -- your custom normal mode mappings
          ["N"] = actions.create,
          ["h"] = actions.goto_parent_dir,
          ["/"] = function()
            vim.cmd('startinsert')
          end,
        },
        ["i"] = {
          -- your custom insert mode mappings
          ["<C-w>"] = function() vim.cmd('normal vbd') end,
        },
      },
      history = { path = db_root .. "/databases/telescope_history.sqlite3", limit = 100 },
    },
  },
})

telescope.load_extension("file_browser")
