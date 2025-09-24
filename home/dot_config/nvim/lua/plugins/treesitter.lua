-- -*-mode:lua-*- vim:ft=lua
local ft = require("user.filetypes")

return {
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      {
        "nvim-treesitter/nvim-treesitter-textobjects",
        config = function() require"user.treesitter.textobjects" end,
      },
      {
        "RRethy/nvim-treesitter-textsubjects",
        config = function() require"user.treesitter.textsubjects" end,
      },
    },
    lazy   = false,
    branch = "main",
    build  = ":TSUpdate",
    cmd    = { "TSInstall", "TSUpdate", "TSUninstall", "TSLog" },
    config = function() require("user.treesitter") end,
  },
  { "JoosepAlviste/nvim-ts-context-commentstring" },
  {
    "hiphish/rainbow-delimiters.nvim",
    event  = { "BufReadPost", "BufNewFile" },
    config = function() require("ui.rainbow-delimiters") end,
  },
  { "windwp/nvim-ts-autotag", ft = ft.autotag, config = function() require("user.treesitter.autotag") end },
  { "andymass/vim-matchup",   ft = ft.matchup, config = function() require("user.treesitter.matchup") end },
  {
    "numToStr/Comment.nvim",
    event  = { "VeryLazy" },
    config = function() require("user.treesitter.comment") end,
  },
  {
    "RRethy/vim-illuminate",
    event  = { "BufReadPost", "BufNewFile" },
    config = function() require("user.treesitter.illuminate") end,
  },
  {
    "Wansmer/treesj",
    cmd    =  "TSJToggle",
    config = function() require("user.treesj") end,
  },
  {
    "folke/todo-comments.nvim", -- Comment highlighter
    dependencies = { "nvim-lua/plenary.nvim" },
    event  = { "BufReadPost", "BufNewFile" },
    config = function() require("todo-comments").setup() end,
  },
}
