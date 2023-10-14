local filetypes = require("user.filetypes")
local is_vscode = vim.g.vscode
return {
  ------------------------------------------------------------------------
  -- Libraries
  ------------------------------------------------------------------------
  { "nvim-lua/plenary.nvim" },
  { "kkharji/sqlite.lua" },
  { "tzachar/fuzzy.nvim" },
  { "MunifTanjim/nui.nvim" },
  { "nvim-tree/nvim-web-devicons" },
  { "mortepau/codicons.nvim", config = function() require("ui.codicons") end },

  ------------------------------------------------------------------------
  -- Vim
  ------------------------------------------------------------------------
  { "vim-jp/vimdoc-ja", ft = "help" },
  { "akinsho/toggleterm.nvim", cmd = "ToggleTerm",   config = function() require("ui.toggleterm") end },
  { "rcarriga/nvim-notify", event  = "VeryLazy",     config = function() require("ui.notify") end },
  -- { "folke/noice.nvim",     event  = "CmdlineEnter", config = function() require("ui.noice") end },
  {
    "goolord/alpha-nvim", -- startup dashboard
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cond   = not is_vscode,
    event  = "BufWinEnter",
    config = function() require("ui.alpha") end,
  },
  -- Quickfix
  { "kevinhwang91/nvim-bqf",     ft = "qf", config = function() require("user.quickfix.bqf") end },
  { "gabrielpoca/replacer.nvim", ft = "qf" },

  ------------------------------------------------------------------------
  -- Appearance
  ------------------------------------------------------------------------
  -- Colorscheme changer
  { "folke/styler.nvim", cmd = "Styler", config = function() require("ui.styler") end },
  -- colorscheme
  { "EdenEast/nightfox.nvim", config = function() require("ui.nightfox") end },

  {
    "NvChad/nvim-colorizer.lua", -- Color code viewer
    -- event  = { "BufReadPost", "BufNewFile" },
    cmd = { "ColorizerToggle" },
    config = function() require("ui.colorizer") end,
  },

  {
    "lukas-reineke/indent-blankline.nvim", -- Indent guides
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    main   = "ibl",
    cond   = not is_vscode,
    event  = { "BufReadPost", "BufNewFile" },
    config = function() require("ui.indent-blankline") end,
  },
  {
    "kevinhwang91/nvim-hlslens", -- Seamlessly saerch & jump
    cond   = not is_vscode,
    event  = "SearchWrapped",
    config = function() require("ui.hlslens") end,
  },
  {
    "petertriho/nvim-scrollbar", -- Extensible Scrollbar
    dependencies = {
      "kevinhwang91/nvim-hlslens",
      "lewis6991/gitsigns.nvim",
    },
    cond   = not is_vscode,
    event  = { "BufReadPost", "BufNewFile" },
    config = function() require("ui.scrollbar") end,
  },
  {
    "akinsho/bufferline.nvim", -- Tab page integration
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cond   = not is_vscode,
    event  = { "BufReadPost", "BufNewFile" },
    config = function() require("ui.bufferline") end,
  },
  {
    "nvim-lualine/lualine.nvim", -- Status Line
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cond   = not is_vscode,
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
    cond   = not is_vscode,
    config = function() require("ui.neo-tree") end,
  },
  {
    "lewis6991/gitsigns.nvim", -- Git integration
    cond   = not is_vscode,
    event  = { "BufReadPost", "BufNewFile" },
    config = function() require("user.gitsigns") end,
  },

  ------------------------------------------------------------------------
  -- Editor Helper
  ------------------------------------------------------------------------
  {
    "folke/which-key.nvim", -- Shortcut / Keymap
    event = "VeryLazy",
    config = function()
      require("user.which-key")
      require("core.keymap")
    end,
  },
  {
    "monaqa/dial.nvim", -- Toggle / Serialize plugin
    event  = { "BufReadPost", "BufNewFile" },
    config = function() require("user.dial") end,
  },
  {
    "windwp/nvim-autopairs", -- autopair: like if/end
    event  = { "BufReadPost", "BufNewFile" },
    config = function() require("lsp.cmp.autopairs") end
  },
  -- *-Improved
  { "haya14busa/vim-asterisk", event = { "BufReadPost", "BufNewFile" } },

  -- File specific Highlighter
  { "MTDL9/vim-log-highlighting",  ft = { "log", "txt", "text" } },
  { "Decodetalkers/csv-tools.lua", ft = "csv" },

  ------------------------------------------------------------------------
  -- LSP: Language Server Protocol
  ------------------------------------------------------------------------
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "williamboman/mason.nvim", config = function() require("lsp.config.mason") end },
      { "williamboman/mason-lspconfig.nvim" },
    },
    cond   = not is_vscode,
    event  = { "BufReadPre", "BufNewFile" },
    config = function() require("lsp.config") end,
  },
  -- INFO: null-ls.nvim alternative
  {
    "nvimtools/none-ls.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    cond   = not is_vscode,
    event  = { "BufReadPre", "BufNewFile" },
    config = function() require("lsp.config.null-ls") end,
  },
  {
    "SmiteshP/nvim-navic",
    dependencies = { "neovim/nvim-lspconfig" },
    cond   = not is_vscode,
    config = function() require("lsp.config.navic") end,
  },
  {
    "nvimdev/lspsaga.nvim", -- Rich GUI for LSP
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "nvim-treesitter/nvim-treesitter",
    },
    event = "LspAttach",
    config = function() require("lsp.config.lspsaga") end,
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    dependencies = {
      "williamboman/mason.nvim",
      "mfussenegger/nvim-dap",
    },
    cmd    = { "DapInstall", "DapUninstall" },
    config = function() require("dap.config.mason-dap") end,
  },
  {
    "j-hui/fidget.nvim", -- Status GUI for LSP
    branch = "legacy",
    event = "LspAttach",
    config = function() require("lsp.config.fidget") end,
  },
  {
    "folke/trouble.nvim", -- Display diagnostics
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cond   = not is_vscode,
    cmd    = { "TroubleToggle", "Trouble" },
    config = function() require("lsp.config.trouble") end,
  },

  ------------------------------------------------------------------------
  -- Completion
  ------------------------------------------------------------------------
  {
    "hrsh7th/nvim-cmp", -- Completion Engine
    cond   = not is_vscode,
    event  = { "InsertEnter", "CmdlineEnter" },
    config = function() require("lsp.cmp") end,
  },
  -- LSP completion sources
  { "hrsh7th/cmp-nvim-lsp-signature-help",  event = "InsertEnter" },
  { "hrsh7th/cmp-nvim-lsp-document-symbol", event = "InsertEnter" },
  { "hrsh7th/cmp-nvim-lsp", cond = not is_vscode, event = "InsertEnter" },
  {
    "onsails/lspkind.nvim",
    cond  = not is_vscode,
    event = "InsertEnter",
  },
  -- { "hrsh7th/cmp-omni" },

  { "hrsh7th/cmp-nvim-lua", ft = "lua" },
  { "mtoohey31/cmp-fish",   ft = "fish" },

  -- { "hrsh7th/cmp-path",            event = { "InsertEnter", "CmdlineEnter" } },
  -- { "hrsh7th/cmp-buffer",          event = { "InsertEnter", "CmdlineEnter" } },
  { "tzachar/cmp-fuzzy-path",      event = { "InsertEnter", "CmdlineEnter" } },
  { "hrsh7th/cmp-cmdline",         event = "CmdlineEnter" },
  { "dmitmel/cmp-cmdline-history", event = "CmdlineEnter" },
  { "tzachar/cmp-fuzzy-buffer",    event = { "InsertEnter", "CmdlineEnter" } },

  {
    "saadparwaiz1/cmp_luasnip",
    cond  = not is_vscode,
    event = { "InsertEnter", "CmdlineEnter" },
  },
  {
    "L3MON4D3/LuaSnip", -- Snippet completion sources
    dependencies = { "rafamadriz/friendly-snippets" },
    -- WARN: Build not working
    -- build = "make install_jsregexp",
    cond   = not is_vscode,
    event  = "InsertEnter",
    config = function ()
      require("luasnip.loaders.from_vscode").lazy_load()
      require("lsp.cmp.luasnip")
    end,
  },

  -- AI assisted completion
  {
    "tzachar/cmp-tabnine",
    build  = "./install.sh",
    -- event  = "InsertEnter",
    cond   = not is_vscode,
    config = function() require("lsp.cmp.tabnine") end,
  },
  {
    "Exafunction/codeium.nvim",
    build  = ":Codeium Auth",
    cond   = not is_vscode,
    -- event  = "InsertEnter",
    config = function() require("lsp.cmp.codeium") end,
  },
  ------------------------------------------------------------------------
  -- DAP: Debug Adapter Protocol
  ------------------------------------------------------------------------
  {
    "mfussenegger/nvim-dap",
    cond   = not is_vscode,
    cmd    = { "DapToggleBreakpoint", "DapContinue", "DapTerminate", "DapStepOver", "DapStepInto", "DapStepOut" },
    config = function() require("dap.config") end,
  },
  {
    "theHamsta/nvim-dap-virtual-text",
    cond   = not is_vscode,
    config = function() require("dap.config.virtual_text") end,
  },
  {
    "rcarriga/nvim-dap-ui",
    cond   = not is_vscode,
    config = function() require("dap.config.ui") end,
  },
  {
    "jbyuki/one-small-step-for-vimkind",
    ft     = "lua",
    cond   = not is_vscode,
    config = function() require("dap.adapters.lua") end,
  },
  {
    "leoluz/nvim-dap-go",
    ft     = "go",
    cond   = not is_vscode,
    config = function() require("dap.adapters.go") end,
  },
  {
    "mfussenegger/nvim-dap-python",
    ft     = "python",
    cond   = not is_vscode,
    config = function() require("dap.adapters.python") end,
  },

  {
    "microsoft/vscode-js-debug",
    build = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out",
    ft    = filetypes.js,
    cond  = not is_vscode,
  },
  {
    "mxsdev/nvim-dap-vscode-js",
    ft = filetypes.js,
    config = function() require("dap.adapters.javascript") end,
  },

  ------------------------------------------------------------------------
  -- Treesitter: Language Parser / Syntax highlighter
  ------------------------------------------------------------------------
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      {
        "nvim-treesitter/nvim-treesitter-textobjects",
        init = function() require("user.treesitter.textobjects") end,
      },
      { "JoosepAlviste/nvim-ts-context-commentstring" },
      -- { "RRethy/nvim-treesitter-textsubjects" },
    },
    build  = function()
      if #vim.api.nvim_list_uis() ~= 0 then vim.api.nvim_command("TSUpdate") end
    end,
    cond   = not is_vscode,
    event  = { "BufReadPost", "BufNewFile" },
    config = function() require("user.treesitter") end,
  },
  {
    "hiphish/rainbow-delimiters.nvim",
    cond   = is_vscode,
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
    config = function() require("illuminate").configure() end,
  },
  {
    "Wansmer/treesj",
    cmd    =  { "TSJToggle", "TSJJoin", "TSJSplit" },
    config = function() require("user.treesitter.treesj") end,
  },
  {
    "m-demare/hlargs.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    cond = not is_vscode,
    event  = { "BufReadPost", "BufNewFile" },
    config = function() require("user.treesitter.hlargs") end,
  },
  {
    "danymat/neogen", -- annotation generator
    dependencies = "nvim-treesitter/nvim-treesitter",
    cmd    = "Neogen",
    config = function() require("user.treesitter.neogen") end,
    -- Uncomment next line if you want to follow only stable versions
    -- version = "*"
  },
  {
    "folke/todo-comments.nvim", -- Comment highlighter
    dependencies = { "nvim-lua/plenary.nvim" },
    cond   = not is_vscode,
    cmd    = "TodoTelescope",
    config = function() require("todo-comments").setup() end,
  },

  ------------------------------------------------------------------------
  -- Telescope: Fuzzy Finder
  ------------------------------------------------------------------------
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    cond   = not is_vscode,
    cmd    = "Telescope",
    module = "Telescope",
    config = function() require("user.telescope") end,
  },
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
    cond   = not is_vscode,
  },
  {
    "nvim-telescope/telescope-frecency.nvim",
    cond   = not is_vscode,
    config = function() require("user.telescope.frecency") end,
  },
  {
    "fdschmidt93/telescope-egrepify.nvim",
    cmd = "Telescope egrepify",
    cond   = not is_vscode,
    config = function() require("user.telescope.egrepify") end,
  },
  {
    "nvim-telescope/telescope-file-browser.nvim",
    cond   = not is_vscode,
    config = function() require("user.telescope.file_browser") end,
  },
  {
    "tsakirist/telescope-lazy.nvim",
    cond   = not is_vscode,
    config = function() require("user.telescope.lazy") end,
  },
  {
    "nvim-telescope/telescope-dap.nvim",
    cond   = not is_vscode,
  },

  ------------------------------------------------------------------------
  -- AI Assistant
  ------------------------------------------------------------------------
  -- GitHub Copilot interaction
  {
    "zbirenbaum/copilot.lua",
    build  = ":Copilot auth",
    cmd    = "Copilot",
    cond   = not is_vscode,
    event  = "InsertEnter",
    config = function() require("ai.copilot") end,
  },
  -- ChatGPT client
  {
    "jackMort/ChatGPT.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-telescope/telescope.nvim",
    },
    cmd    = { "ChatGPT", "ChatGPTRun", "ChatGPTActAs", "ChatGPTCompleteCode", "ChatGPTEditWithInstructions" },
    cond   = not is_vscode,
    config = function() require("ai.chatgpt") end,
  },

  ------------------------------------------------------------------------
  -- Others
  ------------------------------------------------------------------------
  -- Translate Engine
  { "potamides/pantran.nvim", cmd = "Pantran", config = function() require("user.pantran") end },

  { "vim-denops/denops.vim" },
  -- Markdown Previewer
  {
    "kat0h/bufpreview.vim",
    dependencies = { "vim-denops/denops.vim" },
    build = "deno task prepare",
    ft    = "markdown",
    cmd   = "PreviewMarkdown",
  },
}
