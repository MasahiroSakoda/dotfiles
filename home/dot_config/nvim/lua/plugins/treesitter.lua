-- -*-mode:lua-*- vim:ft=lua
local ft = require("config.filetypes")

return {
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      {
        "nvim-treesitter/nvim-treesitter-textobjects",
        branch = "main",
        config = function() require"config.treesitter.textobjects" end,
      },
    },
    branch = "main",
    build  = ":TSUpdate",
    event  = "VeryLazy",
    cmd    = { "TSInstall", "TSUpdate", "TSUninstall", "TSLog" },
    config = function() require("config.treesitter") end,
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    event  = { "BufReadPost", "BufNewFile" },
    config = function() require("config.treesitter.context") end,
  },
  { "RRethy/nvim-treesitter-endwise", ft = ft.endwise },
  {
    "hiphish/rainbow-delimiters.nvim",
    event  = { "BufReadPost", "BufNewFile" },
    config = function() require("ui.rainbow-delimiters") end,
  },
  { "windwp/nvim-ts-autotag", ft = ft.autotag, config = function() require("config.treesitter.autotag") end },
  { "andymass/vim-matchup",   ft = ft.matchup, config = function() require("config.treesitter.matchup") end },
}
