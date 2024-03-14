local ok, telescope = pcall(require, "telescope")
if not ok then return end

local db_root = vim.fn.stdpath("state")

telescope.setup({
  pickers = {
    frecency = {
      hidden = true,
      files  = true,
    },
  },

  extensions = {
    frecency = {
      default_workspace = "CWD",
      db_root = db_root,
      db_safe_mode     = true,
      auto_validate    = true,
      show_scores      = true,
      show_unindexed   = true,
      disable_devicons = false,
      ignore_patterns  = { "*.git/*", "*/tmp/*", "*/node_modules/*" },
      show_filter_column = { "LSP", "CWD", "VIM" },
      use_sqlite = false,
      workspaces = {
        ["nvim"]    = "~/.config/nvim",
        ["lazy"]    = "~/.local/share/nvim/lazy",
        ["project"] = "~/Dev",
        ["doc"]    = "~/Documents",
      },
    },
  },
})
