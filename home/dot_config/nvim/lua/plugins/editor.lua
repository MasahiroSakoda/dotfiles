-- -*-mode:lua-*- vim:ft=lua

return {
  { "vim-jp/vimdoc-ja", ft = "help" },
  {
    "akinsho/toggleterm.nvim",
    cond   = vim.g.vscode,
    cmd    = "ToggleTerm",
    config = function() require("ui.toggleterm") end,
  },
  {
    "rcarriga/nvim-notify",
    cond   = not vim.g.vscode,
    event  = "VeryLazy",
    config = function() require("ui.notify") end,
  },
  {
    "folke/noice.nvim",
    event  = "VeryLazy",
    config = function() require("ui.noice") end,
  },

  {
    "goolord/alpha-nvim", -- startup dashboard
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cond   = not vim.g.is_vscode,
    event  = "BufWinEnter",
    config = function() require("ui.alpha") end,
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
  -- Enhanced character motion
  {
    "folke/flash.nvim",
    cond   = not vim.g.vscode,
    event  = "VeryLazy",
    config = function() require("user.flash") end,
  },
  {
    "monaqa/dial.nvim", -- Toggle / Serialize plugin
    config = function() require("user.dial") end,
  },
  {
    "windwp/nvim-autopairs", -- autopair: like if/end
    event  = { "BufReadPost", "BufNewFile" },
    config = function() require("lsp.cmp.autopairs") end
  },

  -- Quickfix
  { "kevinhwang91/nvim-bqf",     ft = "qf", config = function() require("user.quickfix.bqf") end },
  { "gabrielpoca/replacer.nvim", ft = "qf" },

  -- File specific Highlighter
  { "MTDL9/vim-log-highlighting",  ft = { "log", "txt", "text" } },
  { "Decodetalkers/csv-tools.lua", ft = "csv" },
}
