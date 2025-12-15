-- -*-mode:lua-*- vim:ft=lua

return {
  { "vim-jp/vimdoc-ja", event = { "CmdlineEnter" } },
  {
    "folke/noice.nvim",
    cond   = not vim.g.vscode,
    event  = "VeryLazy",
    config = function() require("ui.noice") end,
  },

  {
    "folke/which-key.nvim", -- Shortcut / Keymap
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
    config   = function() require("user.snacks") end,
  },
  -- Enhanced character motion
  {
    "folke/flash.nvim",
    cond   = not vim.g.vscode,
    event  = "VeryLazy",
    init   = function() require("ui.flash") end,
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
  -- Quickfix
  {
    "kevinhwang91/nvim-bqf",
    ft     = "qf",
    config = function() require("user.quickfix.bqf") end,
  },
  {
    "stevearc/quicker.nvim",
    config = function() require("user.quickfix.quicker") end,
  },

  -- Tex
  {
    "lervag/vimtex",
    ft     = require("user.filetypes").lang.latex,
    config = function() require("user.latex") end,
  },
}
