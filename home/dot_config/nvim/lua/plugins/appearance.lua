-- -*-mode:lua-*- vim:ft=lua

return {
  -- colorscheme
  -- { "EdenEast/nightfox.nvim", config = function() require("ui.nightfox") end },
  { "navarasu/onedark.nvim",  config = function() require("ui.onedark") end },

  {
    "catgoose/nvim-colorizer.lua",-- Color code viewer
    cmd = { "ColorizerToggle" },
    config = function() require("ui.colorizer") end,
  },

  {
    "kevinhwang91/nvim-hlslens", -- Seamlessly saerch & jump
    cond   = not vim.g.vscode,
    event  = { "BufReadPost", "BufNewFile" },
    config = function() require("ui.hlslens") end,
  },
  {
    "akinsho/bufferline.nvim", -- Tab page integration
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cond   = not vim.g.vscode,
    event  = { "BufReadPost", "BufNewFile" },
    config = function() require("ui.bufferline") end,
  },
  {
    "nvim-lualine/lualine.nvim", -- Status Line
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cond   = not vim.g.vscode,
    event  = { "BufReadPost", "BufNewFile" },
    config = function() require("ui.lualine") end,
  },
  {
    "stevearc/oil.nvim", -- File Explorer like buffer
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cond   = not vim.g.vscode,
    config = function() require("ui.oil") end,
  },
  {
    "lewis6991/gitsigns.nvim", -- Git integration
    cond   = not vim.g.vscode,
    event  = { "BufReadPost", "BufNewFile" },
    config = function() require("user.gitsigns") end,
  },
}
