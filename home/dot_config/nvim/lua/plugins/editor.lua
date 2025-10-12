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

  {
    "lervag/vimtex",
    ft     = require("user.filetypes").lang.latex,
    config = function() require("user.latex") end,
  },

  -- File specific Highlighter
  { "MTDL9/vim-log-highlighting",  ft = { "log", "txt", "text" } },
}
