-- -*-mode:lua-*- vim:ft=lua

return {
  -- colorscheme
  { "EdenEast/nightfox.nvim", config = function() require("ui.nightfox") end },

  {
    "NvChad/nvim-colorizer.lua", -- Color code viewer
    -- event  = { "BufReadPost", "BufNewFile" },
    cmd = { "ColorizerToggle" },
    config = function() require("ui.colorizer") end,
  },

  {
    "shellRaining/hlchunk.nvim",
    event  = "UIEnter",
    config = function() require("ui.hlchunk") end,
  },
  {
    "kevinhwang91/nvim-hlslens", -- Seamlessly saerch & jump
    cond   = not vim.g.vscode,
    event  = { "BufReadPost", "BufNewFile" },
    config = function() require("ui.hlslens") end,
  },
  {
    "petertriho/nvim-scrollbar", -- Extensible Scrollbar
    cond   = not vim.g.vscode and vim.g.scrollbar_enabled,
    config = function() require("ui.scrollbar") end,
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
    "nvim-neo-tree/neo-tree.nvim", -- File Explorer w/ tree style
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    cmd    = "Neotree",
    cond   = not vim.g.vscode,
    config = function() require("ui.neo-tree") end,
  },
  {
    "lewis6991/gitsigns.nvim", -- Git integration
    cond   = not vim.g.vscode,
    event  = { "BufReadPost", "BufNewFile" },
    config = function() require("user.gitsigns") end,
  },
  {
    "sindrets/diffview.nvim",
    cond   = not vim.g.vscode,
    cmd    = { "DiffviewOpen", "DiffviewToggleFiles", "DiffviewFocusFiles", "DiffviewFileHistory" },
    config = function() require("ui.diffview") end,
  },
}
