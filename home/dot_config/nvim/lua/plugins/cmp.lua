-- -*-mode:lua-*- vim:ft=lua

return {
  {
    "hrsh7th/nvim-cmp", -- Completion Engine
    dependencies = {
      -- LSP completion sources
      "hrsh7th/cmp-nvim-lsp",
      "onsails/lspkind.nvim",

      "hrsh7th/cmp-path",
      -- "tzachar/cmp-fuzzy-path",
      "hrsh7th/cmp-buffer",
      -- "tzachar/cmp-fuzzy-buffer",
      "hrsh7th/cmp-cmdline",
      "dmitmel/cmp-cmdline-history",

      "saadparwaiz1/cmp_luasnip",

      -- AI assisted completion
      -- GitHub Copilot interaction
      {
        "zbirenbaum/copilot.lua",
        build  = ":Copilot auth",
        cond   = vim.g.copilot,
        cmd    = "Copilot",
        config = function() require("ai.copilot") end,
      },
      {
        "zbirenbaum/copilot-cmp",
        cond   = vim.g.copilot,
        config = function() require("lsp.cmp.copilot") end,
      },
      {
        "Exafunction/codeium.nvim",
        build  = ":Codeium Auth",
        cond   = vim.g.codeium,
        config = function() require("lsp.cmp.codeium") end,
      },
      {
        "tzachar/cmp-tabnine",
        build = './install.sh',
        cond   = vim.g.tabnine,
        config = function() require("lsp.cmp.tabnine") end,
      },
    },
    event  = { "InsertEnter", "CmdlineEnter" },
    config = function() require("lsp.cmp") end,
  },
  { "mtoohey31/cmp-fish",   ft = "fish" },

  {
    "L3MON4D3/LuaSnip", -- Snippet completion sources
    dependencies = { "rafamadriz/friendly-snippets" },
    build = "make install_jsregexp",
    version = "v2.*",
    event   = "InsertEnter",
    config  = function ()
      require("lsp.cmp.luasnip")
      require("luasnip.loaders.from_vscode").lazy_load()
    end,
  },
}