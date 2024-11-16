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
      prompt_title = string.format("Frecency Search in %s", require("utils").shorten_path(vim.fn.getcwd())),
      db_root = db_root,
      db_safe_mode     = true,
      auto_validate    = true,
      show_scores      = true,
      show_unindexed   = true,
      disable_devicons = false,
      ignore_patterns  = { "*.git/*", "*/tmp/*", "term://*" },
      show_filter_column = { "LSP", "CWD", "VIM" },
      use_sqlite = false,
      workspaces = {
        ["dots"]    = "~/.local/share/chezmoi",
        ["lazy"]    = "~/.local/share/nvim/lazy",
        ["project"] = "~/Dev",
        ["doc"]    = "~/Documents",
      },
    },
  },
})
