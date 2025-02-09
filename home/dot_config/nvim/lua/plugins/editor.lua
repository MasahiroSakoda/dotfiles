-- -*-mode:lua-*- vim:ft=lua

return {
  { "vim-jp/vimdoc-ja", event = { "CmdlineEnter" } },
  {
    "akinsho/toggleterm.nvim",
    cond   = not vim.g.vscode,
    cmd    = "ToggleTerm",
    config = function() require("ui.toggleterm") end,
  },
  {
    "folke/noice.nvim",
    cond   = not vim.g.vscode,
    event  = "VeryLazy",
    config = function() require("ui.noice") end,
  },

  {
    "folke/which-key.nvim", -- Shortcut / Keymap
    cond   = not vim.g.vscode,
    event  = "VeryLazy",
    config = function()
      require("user.which-key")
      require("core.keymap")
    end,
  },
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy     = false,
    opts = {
      bigfile      = require("user.bigfile"),
      quickfile    = require("user.quickfile"),
      indent       = require("user.indent"),
      toggle       = require("user.toggle"),
      dashboard    = require("ui.dashboard"),
      input        = require("ui.input"),
      explorer     = require("ui.explorer"),
      picker       = require("ui.picker"),
      notifier     = require("ui.notifier"),
      terminal     = require("ui.terminal"),
      zen          = require("ui.zen"),
      statuscolumn = { enabled = true },
      words        = { enabled = false },
      styles       = {
        notification = {
          wo = { wrap = true } -- Wrap notifications
        },
      },
    }
  },
  -- Enhanced character motion
  {
    "folke/flash.nvim",
    cond   = not vim.g.vscode,
    config = function() require("user.flash") end,
  },
  {
    "monaqa/dial.nvim", -- Toggle / Serialize plugin
    config = function() require("user.dial") end,
  },
  {
    "windwp/nvim-autopairs", -- autopair: like if/end
    cond   = not vim.g.vscode,
    event  = { "BufReadPost", "BufNewFile" },
    config = function() require("lsp.cmp.autopairs") end
  },

  -- File specific Highlighter
  { "MTDL9/vim-log-highlighting",  ft = { "log", "txt", "text" } },
}
