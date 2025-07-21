local ok, treesitter = pcall(require, "nvim-treesitter.configs")
if not ok then return end

local enable  = { enable  = true }

treesitter.setup({
  modules = {},
  sync_install = true,
  auto_install = true,
  ignore_install = {},
  ensure_installed = require("user.filetypes").treesitter,
  -- incremental_selection = enable,
  -- See https://alpha2phi.medium.com/neovim-pde-init-lua-a6c22bc63e80
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection    = "gss",
      node_incremental  = "gsi",
      node_decremental  = "gsd",
      scope_incremental = "gsc",
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

  textobjects = {
    select = {
      enable    = true,
      lockahead = true,
      keymaps = {
        ["ic"] = { query = "@class.inner",       desc = "Select inner part of a class" },
        ["ac"] = { query = "@class.outer",       desc = "Select outer part of a class" },
        ["if"] = { query = "@function.inner",    desc = "Select inner part of a method/func definition" },
        ["af"] = { query = "@function.outer",    desc = "Select outer part of a method/func definition" },
        ["ia"] = { query = "@parameter.outer",   desc = "Select inner part of a param / arg" },
        ["aa"] = { query = "@paramter.inner",    desc = "Select outer part of a param / arg" },
        ["ib"] = { query = "@block.inner",       desc = "Select inner part of a block" },
        ["ab"] = { query = "@block.outer",       desc = "Select outer part of a block" },
        ["il"] = { query = "@loop.inner",        desc = "Select inner part of a loop" },
        ["al"] = { query = "@loop.outer",        desc = "Select outer part of a loop" },
        ["i?"] = { query = "@conditional.inner", desc = "Select inner part of a conditional" },
        ["a?"] = { query = "@conditional.outer", desc = "Select outer part of a conditional" },
        ["i/"] = { query = "@comment.inner",     desc = "Select inner part of a comment" },
        ["a/"] = { query = "@comment.outer",     desc = "Select outer part of a comment" },
      },
    },
    swap = {
      enable    = true,
      swap_previous = {
        ["<M-Space>p"] = { query = "@parameter.inner", desc = "Swap with next argument" },
      },
      swap_next = {
        ["<M-Space>n"] = { query = "@parameter.inner", desc = "Swap with prev argument" },
      },
    },
    move = {
      enable   = true,
      set_jump = true,
      goto_previous_start = {
        ["[c"] = { query = "@class.outer",       desc = "Prev class start" },
        ["[f"] = { query = "@function.outer",    desc = "Prev function start" },
        ["[i"] = { query = "@conditional.outer", desc = "Prev conditional start" },
        ["[l"] = { query = "@loop.outer",        desc = "Prev loop start" },
        ["[m"] = { query = "@call.outer",        desc = "Prev function call start" },
      },
      goto_previous_end = {
        ["[C"] = { query = "@class.outer",       desc = "Prev class end" },
        ["[F"] = { query = "@function.outer",    desc = "Prev function end" },
        ["[I"] = { query = "@conditional.outer", desc = "Prev conditional end" },
        ["[L"] = { query = "@loop.outer",        desc = "Prev loop end" },
        ["[M"] = { query = "@call.outer",        desc = "Prev function call end" },
      },
      goto_next_start = {
        ["]c"] = { query = "@class.outer",       desc = "Next class start" },
        ["]f"] = { query = "@function.outer",    desc = "Next function start" },
        ["]i"] = { query = "@conditional.outer", desc = "Next conditional start" },
        ["]l"] = { query = "@loop.outer",        desc = "Next loop start" },
        ["]m"] = { query = "@call.outer",        desc = "Next function call start" },
      },
      goto_next_end = {
        ["]C"] = { query = "@class.outer",       desc = "Next class end" },
        ["]F"] = { query = "@function.outer",    desc = "Next function end" },
        ["]I"] = { query = "@conditional.outer", desc = "Next conditional end" },
        ["]L"] = { query = "@loop.outer",        desc = "Next loop end" },
        ["]M"] = { query = "@call.outer",        desc = "Next function call end" },
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

-- Register Extended filetypes
vim.filetype.add({
  extension = {
    scpt  = "applescript",
    plist = "xml",
    ttx   = "xml",
    mdx   = "markdown.mdx",
    mdc   = "markdown.mdc",
  },
  filetypes = {
    Brewfile = "ruby",
    Caskfile = "ruby",
    Masfile  = "ruby",
  },
  pattern = {
    ["env%..*"]       = "dotenv",
    [".*%.env%..*"]   = "dotenv",
    [".*%.html%.hbs"] = "handlebars.html",
    [".*%.json%.hbs"] = "handlebars.json",
    [".*%.js%.hbs"]   = "handlebars.javascript",
    [".*%.ts%.hbs"]   = "handlebars.typescript",
  },
})
vim.treesitter.language.register("markdown", { "mdx", "mdc" })
