local filetypes = require("user.filetypes")
return {
  ------------------------------------------------------------------------
  -- Libraries
  ------------------------------------------------------------------------
  { "nvim-lua/plenary.nvim" },
  { "kkharji/sqlite.lua" },
  { "tzachar/fuzzy.nvim" },
  { "MunifTanjim/nui.nvim" },
  { "kyazdani42/nvim-web-devicons" },
  { "mortepau/codicons.nvim", config = function() require("ui.codicons") end },
  { "nathom/filetype.nvim",   config = function() require("core.filetype") end },

  ------------------------------------------------------------------------
  -- Vim
  ------------------------------------------------------------------------
  { "vim-jp/vimdoc-ja", ft = "help" },
  { "dstein64/vim-startuptime", cmd = "StartupTime" },
  { "jghauser/mkdir.nvim" },
  { "rcarriga/nvim-notify",    event = "VeryLazy", config = function() require("ui.notify") end },
  { "akinsho/toggleterm.nvim", cmd = "ToggleTerm", config = function() require("ui.toggleterm") end },
  {
    "goolord/alpha-nvim", -- startup dashboard
    dependencies = { "kyazdani42/nvim-web-devicons" },
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
  { "folke/tokyonight.nvim" },
  { "rebelot/kanagawa.nvim" },

  {
    "NvChad/nvim-colorizer.lua", -- Color code viewer
    event  = { "BufReadPost", "BufNewFile" },
    config = function() require("ui.colorizer") end,
  },

  {
    "lukas-reineke/indent-blankline.nvim", -- Indent guides
    event  = { "BufReadPost", "BufNewFile" },
    config = function() require("ui.indent-blankline") end,
  },
  {
    "kevinhwang91/nvim-hlslens", -- Seamlessly saerch & jump
    event  = "SearchWrapped",
    config = function() require("ui.hlslens") end,
  },
  {
    "petertriho/nvim-scrollbar", -- Extensible Scrollbar
    dependencies = {
      "kevinhwang91/nvim-hlslens",
      "lewis6991/gitsigns.nvim",
    },
    event  = { "BufReadPost", "BufNewFile" },
    config = function() require("ui.scrollbar") end,
  },
  {
    "akinsho/bufferline.nvim", -- Tab page integration
    dependencies = { "kyazdani42/nvim-web-devicons" },
    event  = { "BufReadPost", "BufNewFile" },
    config = function() require("ui.bufferline") end,
  },
  {
    "nvim-lualine/lualine.nvim", -- Status Line
    dependencies = { "kyazdani42/nvim-web-devicons" },
    event  = { "BufReadPost", "BufNewFile" },
    config = function() require("ui.lualine") end,
  },
  {
    "nvim-neo-tree/neo-tree.nvim", -- File Explorer w/ tree style
    branch = "v2.x",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "kkharji/sqlite.lua",
      "kyazdani42/nvim-web-devicons",
    },
    cmd    = "Neotree",
    config = function() require("ui.neo-tree") end,
  },
  {
    "lewis6991/gitsigns.nvim", -- Git integration
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
    "phaazon/hop.nvim", -- Cursor: EasyMotion
    branch = "v2",
    cmd = { "HopWord", "HopLine", "HopAnywhere", "HopAnywhereCurrentLine", "HopPattern" },
    config = function() require("ui.hop") end,
  },
  {
    "windwp/nvim-autopairs", -- autopair: like if/end
    event  = { "BufReadPost", "BufNewFile" },
    config = function() require("lsp.cmp.autopairs") end
  },
  -- *-Improved
  { "haya14busa/vim-asterisk", event = { "BufReadPost", "BufNewFile" } },

  {
    "RaafatTurki/hex.nvim", -- Hexadecimal Editor
    cmd    = { "HexDump", "HexAssemble", "HexToggle" },
    config = function() require("hex").setup() end,
  },

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
    event  = { "BufReadPre", "BufNewFile" },
    config = function() require("lsp.config") end,
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    event  = { "BufReadPre", "BufNewFile" },
    config = function() require("lsp.config.null-ls") end,
  },
  {
    "SmiteshP/nvim-navic",
    dependencies = { "neovim/nvim-lspconfig" },
    config = function() require("lsp.config.navic") end,
  },
  {
    "glepnir/lspsaga.nvim", -- Rich GUI for LSP
    event  = { "BufReadPost", "BufNewFile" }, -- Do not change for nvim-navic
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
  -- Status GUI for LSP
  { "j-hui/fidget.nvim", event = "LspAttach", config = function() require("lsp.config.fidget") end },
  {
    "folke/trouble.nvim", -- Display diagnostics
    dependencies = { "kyazdani42/nvim-web-devicons" },
    cmd    = { "TroubleToggle", "Trouble" },
    config = function() require("lsp.config.trouble") end,
  },

  ------------------------------------------------------------------------
  -- Completion
  ------------------------------------------------------------------------
  {
    "hrsh7th/nvim-cmp", -- Completion Engine
    event  = { "InsertEnter", "CmdlineEnter" },
    config = function() require("lsp.cmp") end,
  },
  -- LSP completion sources
  { "hrsh7th/cmp-nvim-lsp-signature-help",  event = "InsertEnter" },
  { "hrsh7th/cmp-nvim-lsp-document-symbol", event = "InsertEnter" },
  { "hrsh7th/cmp-nvim-lsp", event = "InsertEnter" },
  { "onsails/lspkind.nvim", event = "InsertEnter" },
  -- { "hrsh7th/cmp-omni" },

  { "hrsh7th/cmp-nvim-lua", ft = "lua" },
  { "mtoohey31/cmp-fish",   ft = "fish" },

  { "hrsh7th/cmp-path",            event = { "InsertEnter", "CmdlineEnter" } },
  { "hrsh7th/cmp-buffer",          event = { "InsertEnter", "CmdlineEnter" } },
  { "tzachar/cmp-fuzzy-path",      event = { "InsertEnter", "CmdlineEnter" } },
  { "hrsh7th/cmp-cmdline",         event = "CmdlineEnter" },
  { "dmitmel/cmp-cmdline-history", event = "CmdlineEnter" },
  { "tzachar/cmp-fuzzy-buffer",    event = { "InsertEnter", "CmdlineEnter" } },

  { "saadparwaiz1/cmp_luasnip" },
  {
    "L3MON4D3/LuaSnip", -- Snippet completion sources
    dependencies = { "rafamadriz/friendly-snippets" },
    -- FIXME: Build not woring
    -- build = "make install_jsregexp",
    event = "InsertEnter",
    config = function ()
      require("luasnip.loaders.from_vscode").lazy_load()
      -- require("lsp.cmp.luasnip")
    end,
  },

  -- AI assisted completion
  {
    "tzachar/cmp-tabnine",
    build  = "./install.sh",
    config = function() require("lsp.cmp.tabnine") end,
  },
  {
    "jcdickinson/codeium.nvim",
    dependencies = { "jcdickinson/http.nvim", build = "cargo build --workspace --release" },
    build  = ":Codeium Auth",
    config = function() require("lsp.cmp.codeium") end,
  },
  ------------------------------------------------------------------------
  -- DAP: Debug Adapter Protocol
  ------------------------------------------------------------------------
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      { "theHamsta/nvim-dap-virtual-text", config = function() require("dap.config.virtual_text") end },
      { "rcarriga/nvim-dap-ui",            config = function() require("dap.config.ui") end },
    },
    cmd    = { "DapToggleBreakpoint", "DapContinue", "DapTerminate", "DapStepOver", "DapStepInto", "DapStepOut" },
    config = function() require("dap.config") end,
  },
  { "jbyuki/one-small-step-for-vimkind", ft = "lua",        config = function() require("dap.adapters.lua") end },
  { "leoluz/nvim-dap-go",                ft = "go",         config = function() require("dap.adapters.go") end },
  { "mfussenegger/nvim-dap-python",      ft = "python",     config = function() require("dap.adapters.python") end },

  {
    "microsoft/vscode-js-debug",
    build = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out",
    ft    = filetypes.js,
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
      { "RRethy/nvim-treesitter-endwise" },
      { "mrjones2014/nvim-ts-rainbow" },
      { "windwp/nvim-ts-autotag", ft = filetypes.autotag },
      { "andymass/vim-matchup" },
    },
    build  = function()
      if #vim.api.nvim_list_uis() ~= 0 then vim.api.nvim_command("TSUpdate") end
    end,
    event  = { "BufReadPost", "BufNewFile" },
    config = function() require("user.treesitter") end,
  },
  {
    "numToStr/Comment.nvim",
    event  = { "BufReadPost", "BufNewFile" },
    config = function() require("user.treesitter.Comment") end,
  },
  {
    "RRethy/vim-illuminate",
    event  = { "BufReadPost", "BufNewFile" },
    config = function() require("illuminate").configure() end,
  },
  {
    "m-demare/hlargs.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    event  = { "BufReadPost", "BufNewFile" },
    config = function() require("user.treesitter.hlargs") end,
  },
  -- Hilighter for current cursor scope
  { "folke/twilight.nvim", cmd = "Twilight", config = function() require("twilight").setup() end },
  {
    "folke/todo-comments.nvim", -- Comment Hilighter
    dependencies = { "nvim-lua/plenary.nvim" },
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
      "kyazdani42/nvim-web-devicons",
    },
    cmd    = "Telescope",
    config = function() require("user.telescope") end,
  },
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
  },
  { "nvim-telescope/telescope-frecency.nvim", dependencies = "kkharji/sqlite.lua" },
  { "nvim-telescope/telescope-file-browser.nvim" },
  { "tsakirist/telescope-lazy.nvim" },
  { "LukasPietzschmann/telescope-tabs",  config = function() require("user.telescope.tabs") end },
  { "nvim-telescope/telescope-dap.nvim", config = function() require("user.telescope.dap") end },

  ------------------------------------------------------------------------
  -- AI Assistant
  ------------------------------------------------------------------------
  {
    "jackMort/ChatGPT.nvim", -- ChatGPT client
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-telescope/telescope.nvim",
    },
    cmd = {
      "ChatGPT",
      "ChatGPTRun",
      "ChatGPTActAs",
      "ChatGPTCompleteCode",
      "ChatGPTEditWithInstructions",
    },
    config = function() require("ai.chatgpt") end,
  },

  {
    "Bryley/neoai.nvim",
    dependencies = { "MunifTanjim/nui.nvim" },
    cmd = {
      "NeoAI", "NeoAIOpen", "NeoAIClose", "NeoAIToggle", "NeoAIShortcut",
      "NeoAIContext", "NeoAIContextOpen", "NeoAIContextClose",
      "NeoAIInject", "NeoAIInjectCode", "NeoAIInjectContext", "NeoAIInjectContextCode"
    },
    keys = {
      { "<Leader>as", desc = "summarize text" },
      { "<Leader>ar", desc = "refactor code" },
      { "<Leader>ag", desc = "generate git message" },
    },
    config = function() require("ai.neoai") end,
  },

  -- Multi-backend supported AI: ChatGPT, GPT-4, BingAI
  {
    "archibate/nvim-gpt",
    dependencies = { "nvim-telescope/telescope.nvim" },
    cmd = { "GPTModel", "GPTOpen", "GPTClose", "GPTToggle", "GPTCode" },
    config = function() require("ai.nvim-gpt") end,
  },

  ------------------------------------------------------------------------
  -- Others
  ------------------------------------------------------------------------
  { "tyru/open-browser.vim", cmd = { "OpenBrowser", "OpenBrowserSearch" } },
  {
    "tyru/open-browser-github.vim",
    dependencies = { "tyru/open-browser.vim" },
    cmd = { "OpenGithubProject", "OpenGithubFile", "OpenGithubIssue", "OpenGithubCommit", "OpenGithubPullReq" },
  },

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
