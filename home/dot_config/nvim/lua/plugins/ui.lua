return {
  {
    "navarasu/onedark.nvim",
    priority = 1000,
    config = function() require("config.ui.onedark") end,
  },
  {
    "catgoose/nvim-colorizer.lua",
    cmd = { "ColorizerToggle" },
    config = function() require("config.ui.colorizer") end,
  },
  {
    "kevinhwang91/nvim-hlslens",
    cond   = not vim.g.vscode,
    event  = { "CmdlineEnter" },
    config = function() require("config.ui.hlslens") end,
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cond   = not vim.g.vscode,
    event  = { "VeryLazy" },
    config = function() require("config.ui.lualine") end,
  },
  {
    "akinsho/bufferline.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cond   = not vim.g.vscode,
    event  = { "BufReadPost", "BufNewFile" },
    config = function() require("config.ui.bufferline") end,
  },
}
