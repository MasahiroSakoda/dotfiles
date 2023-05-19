local ok, treesitter = pcall(require, "nvim-treesitter.configs")
if not ok then return end

local enable  = { enable  = true }

treesitter.setup({
  ensure_installed = require("user.filetypes").treesitter,
  -- incremental_selection = enable,
  -- See https://alpha2phi.medium.com/neovim-pde-init-lua-a6c22bc63e80
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection    = "<C-Space>",
      node_incremental  = "<C-Space>",
      node_decremental  = "<M-S>",
      scope_incremental = "<C-s>>",
    },
  },
  autopairs = enable,
  autotag   = enable,
  endwise   = enable,
  matchup   = {
    enable  = true,
    include_match_words = true,
  },
  highlight = {
    enable = true,
    use_languagetree = true,
    additional_vim_regex_highlighting = true,
  },
  indent  = enable,
  rainbow = {
    enable = true,
    disable = {},
    extend_mode = true,
    max_file_lines = 1000,
    -- colors = {},
    -- termcolors = {},
  },

  textobjects = {
    select = {
      enable    = true,
      lockahead = true,
      keymaps = {
        ["if"] = "@function.inner",
        ["af"] = "@function.outer",
        ["ic"] = "@conditional.inner",
        ["ac"] = "@conditional.outer",
        ["iC"] = "@class.inner",
        ["aC"] = "@class.outer",
        ["ie"] = "@block.inner",
        ["ae"] = "@block.outer",
        ["il"] = "@loop.inner",
        ["al"] = "@loop.outer",
        ["is"] = "@statement.inner",
        ["as"] = "@statement.outer",
        ["id"] = "@comment.inner",
        ["ad"] = "@comment.outer",
        ["im"] = "@call.inner",
        ["am"] = "@call.outer",
      },
    },
    swap = {
      enable    = true,
      swap_next = {
        -- ["<leader>a"] = "@parameter.inner",
        ["<M-Space><M-n>"] = "@parameter.inner",
      },
      swap_previous = {
        -- ["<leader>A"] = "@parameter.inner",
        ["<M-Space><M-p>"] = "@parameter.inner",
      },
    },
    move = {
      enable   = true,
      set_jump = true,
      goto_previous_start = {
        ["[m"] = "@function.outer",
        ["[["] = "@class.outer",
      },
      goto_previous_end = {
        ["[M"] = "@function.outer",
        ["[]"] = "@class.outer",
      },
      goto_next_start = {
        ["]m"] = "@function.outer",
        ["]]"] = "@class.outer",
      },
      goto_next_end = {
        ["]M"] = "@function.outer",
        ["]["] = "@class.outer",
      },
    },
  },
  context_commentstring = {
    enable = true,
    enable_autocmd = false,
    config = {
      lua = { __default = "-- %s", __multiline = "--[[ %s ]]" },
      javascript = {
        __default     = "// %s",
        jsx_element   = "{/* %s */}",
        jsx_fragment  = "{/* %s */}",
        jsx_attribute = "// %s",
        comment       = "// %s",
      },
      typescript = { __default = "// %s", __multiline = "/* %s */" },
      javascriptreact = { style_element = "{/*%s*/}" },
      typescriptreact = {
        __default     = "xx// %s",
        jsx_element   = "xx{/* %s */}",
        jsx_fragment  = "xx{/* %s */}",
        jsx_attribute = "xx// %s",
        comment       = "xx// %s",
      },
      css = { __default = '// %s', __multiline = '{/* %s */}'
      },
      vue = {
        __default = "// %s",
        html      = "<!-- %s -->",
        css_style = "/* %s */",
        comment   = "// %s",
      },
      c   = { __default = "// %s", __multiline = "{/* %s */}" },
      cpp = { __default = "// %s", __multiline = "{/* %s */}" },
    },
  },
})
