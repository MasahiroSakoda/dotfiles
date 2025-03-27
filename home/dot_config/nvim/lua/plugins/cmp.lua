-- -*-mode:lua-*- vim:ft=lua
require("core.complete")

return {
  -- {
  --   "hrsh7th/nvim-cmp", -- Completion Engine
  --   dependencies = {
  --     -- LSP completion sources
  --     "hrsh7th/cmp-nvim-lsp",
  --     "onsails/lspkind.nvim",

  --     "hrsh7th/cmp-path",
  --     -- "tzachar/cmp-fuzzy-path",
  --     "hrsh7th/cmp-buffer",
  --     -- "tzachar/cmp-fuzzy-buffer",
  --     "hrsh7th/cmp-cmdline",
  --     "dmitmel/cmp-cmdline-history",
  --   },
  --   event  = { "InsertEnter", "CmdlineEnter" },
  --   config = function() require("lsp.cmp") end,
  -- },

  -- { "saadparwaiz1/cmp_luasnip", event = { "BufReadPre", "BufNewFile" } },
  {
    "L3MON4D3/LuaSnip", -- Snippet completion sources
    dependencies = { "rafamadriz/friendly-snippets" },
    build = "make install_jsregexp",
    version = "v2.*",
    event   = "InsertEnter",
    config  = function () require("lsp.cmp.luasnip") end,
    keys = {
      -- {
      --   "<Tab>",
      --   function() return require("luasnip").expand_or_jumpable() and require("luasnip").expand_or_jump() end,
      --   expr   = true,
      --   silent = true,
      --   mode   = { "i", "s" },
      -- },
      -- {
      --   "<S-Tab>",
      --   function() return require("luasnip").jumpable(-1) and require("luasnip").jump(-1) end,
      --   expr   = true,
      --   silent = true,
      --   mode   = { "i", "s" },
      -- },
      {
        "<C-p>",
        function() return require("luasnip").choice_active() and "<Plug>luasnip-prev-choice" or "<C-e>" end,
        expr   = true,
        silent = true,
        mode   = { "i", "s" },
      },
      {
        "<C-n>",
        function() return require("luasnip").choice_active() and "<Plug>luasnip-next-choice" or "<C-e>" end,
        expr   = true,
        silent = true,
        mode   = { "i", "s" },
      },
    },
  },
  {
    "saghen/blink.cmp",
    version = "1.*",
    dependencies = {
      "saghen/blink.compat",
      "onsails/lspkind.nvim",
    },
    event = { "InsertEnter" },
    config = function() require("lsp.cmp.blink") end,
  },
}
