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
    config  = function ()
      require("lsp.cmp.luasnip")
      require("luasnip.loaders.from_vscode").lazy_load({
        override_priority = 1000,
      })
      require("luasnip.loaders.from_lua").lazy_load({
        paths = { vim.fn.stdpath("config") .. "/lua/snippets" },
        override_priority = 2000,
      })
    end,
  },
  {
    "saghen/blink.cmp",
    version = "0.*",
    dependencies = {
      "saghen/blink.compat",
      "onsails/lspkind.nvim",
    },
    event = { "InsertEnter" },
    config = function() require("lsp.cmp.blink") end,
  },
}
