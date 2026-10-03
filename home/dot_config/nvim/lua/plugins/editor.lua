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
  {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd    = { "Oil" },
    config = function() require("config.editor.oil") end,
  },
  {
    "saghen/blink.cmp",
    version = "1.*",
    dependencies = { "onsails/lspkind.nvim" },
    cond         = not vim.g.vscode,
    event        = { "InsertEnter", "CmdlineEnter" },
    opts_extend  = { "sources.default", "sources.completion.enabled_providers" },
    config       = function() require("config.editor.completion") end,
  },
  {
    "L3MON4D3/LuaSnip", -- Snippet completion sources
    dependencies = { "rafamadriz/friendly-snippets" },
    build   = "make install_jsregexp",
    version = "v2.*",
    event   = "InsertEnter",
    config  = function () require("config.editor.snippets") end,
  },
  {
    "lewis6991/gitsigns.nvim", -- Git integration
    cond   = not vim.g.vscode,
    event  = { "BufReadPost", "BufNewFile" },
    config = function() require("config.editor.gitsigns") end,
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown", "markdown.mdc", "markdown.mdx", "vimwiki" },
    config = function() require("config.editor.render-markdown") end,
  },
  -- Tex
  {
    "lervag/vimtex",
    ft     = require("config.editor.filetypes").lang.latex,
    config = function() require("config.editor.latex") end,
  },
}
