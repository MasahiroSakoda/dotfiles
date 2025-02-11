-- -*-mode:lua-*- vim:ft=lua
local filetypes = require("user.filetypes")

return {
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      {
        "nvim-treesitter/nvim-treesitter-textobjects",
        init = function() require("user.treesitter.textobjects") end,
      },
      -- { "RRethy/nvim-treesitter-textsubjects" },
    },
    build  = function()
      if #vim.api.nvim_list_uis() ~= 0 then vim.api.nvim_command("TSUpdate") end
    end,
    event  = { "BufReadPost", "BufNewFile" },
    config = function() require("user.treesitter") end,
  },
  { "JoosepAlviste/nvim-ts-context-commentstring" },
  {
    "hiphish/rainbow-delimiters.nvim",
    event  = { "BufReadPost", "BufNewFile" },
    config = function() require("ui.rainbow-delimiters") end,
  },
  { "windwp/nvim-ts-autotag",         ft = filetypes.autotag },
  { "RRethy/nvim-treesitter-endwise", ft = filetypes.endwise },
  { "andymass/vim-matchup",           ft = filetypes.matchup },
  {
    "numToStr/Comment.nvim",
    event  = { "BufReadPost", "BufNewFile" },
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
