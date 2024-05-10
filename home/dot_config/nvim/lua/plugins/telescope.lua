-- -*-mode:lua-*- vim:ft=lua

return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    cond   = not vim.g.vscode,
    cmd    = "Telescope",
    module = "Telescope",
    config = function() require("user.telescope") end,
  },
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build  = [[
      cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && \
      cmake --build build --config Release && \
      cmake --install build --prefix build
    ]],
    cond   = not vim.g.vscode,
  },
  {
    "nvim-telescope/telescope-frecency.nvim",
    cond   = not vim.g.vscode,
    config = function() require("user.telescope.frecency") end,
  },
  {
    "fdschmidt93/telescope-egrepify.nvim",
    cond   = not vim.g.vscode,
    cmd    = "Telescope egrepify",
    config = function() require("user.telescope.egrepify") end,
  },
  {
    "nvim-telescope/telescope-live-grep-args.nvim",
    cond  = not vim.g.vscode,
    cmd   = "Telescope live_grep",
    config = function() require("user.telescope.lga") end,
  },
  {
    "nvim-telescope/telescope-file-browser.nvim",
    cond   = not vim.g.vscode,
    config = function() require("user.telescope.file_browser") end,
  },
  {
    "benfowler/telescope-luasnip.nvim",
    cond   = not vim.g.vscode,
    module = "telescope._extensions.luasnip",
  },
  {
    "tsakirist/telescope-lazy.nvim",
    cond   = not vim.g.vscode,
    config = function() require("user.telescope.lazy") end,
  },
  {
    "nvim-telescope/telescope-dap.nvim",
    cond   = not vim.g.vscode,
  },
}
