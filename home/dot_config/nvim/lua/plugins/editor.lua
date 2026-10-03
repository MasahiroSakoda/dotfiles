-- -*-mode:lua-*- vim:ft=lua

return {
  {
    "folke/noice.nvim",
    cond   = not vim.g.vscode,
    event  = "VeryLazy",
    config = function() require("config.editor.noice") end,
  },

  {
    "folke/which-key.nvim", -- Shortcut / Keymap
    event  = "VeryLazy",
    config = function()
      require("config.editor.which-key")
      require("config.core.keymap")
    end,
  },
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy     = false,
    config   = function() require("config.snacks") end,
  },
  -- Enhanced character motion
  {
    "folke/flash.nvim",
    cond   = not vim.g.vscode,
    config = function() require("config.editor.flash") end,
  },
  {
    "monaqa/dial.nvim", -- Toggle / Serialize plugin
    config = function() require("config.editor.dial") end,
  },
  {
    "windwp/nvim-autopairs", -- autopair: like if/end
    cond   = not vim.g.vscode,
    event  = { "BufReadPost", "BufNewFile" },
    config = function() require("config.editor.autopairs") end
  },
  {
    "kylechui/nvim-surround",
    version = "^4",
    event   = { "BufReadPost", "BufNewFile" },
    config = function()
      vim.g.nvim_surround_no_normal_mappings = true
    end,
  },
  {
    "wansmer/treesj",
    event = "VeryLazy",
    config = function() require("config.editor.treesj") end,
  },
  {
    "folke/trouble.nvim",
    cmd = { "Trouble" },
    config = function() require("config.editor.trouble") end,
  },
  -- Tex
  {
    "lervag/vimtex",
    ft     = require("config.editor.filetypes").lang.latex,
    config = function() require("config.editor.latex") end,
  },
}
