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
  {
    "kylechui/nvim-surround",
    version = "^3.0.0",
    event   = { "BufReadPost", "BufNewFile" },
    config  = function() require("user.surround") end,
  },
  {
    "folke/trouble.nvim",
    cmd = { "Trouble" },
    config = function() require("lsp.config.trouble") end,
  },
  {
    "stevearc/conform.nvim",
    event  = { "BufWritePre" },
    cmd    = { "ConformInfo" },
    config = function() require("user.formatter") end,
  },
  -- Tex
  {
    "lervag/vimtex",
    ft     = require("user.filetypes").lang.latex,
    config = function() require("user.latex") end,
  },
}
