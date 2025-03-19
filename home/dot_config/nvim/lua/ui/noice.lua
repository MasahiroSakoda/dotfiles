local ok, noice = pcall(require, "noice")
if not ok then return end

noice.setup({
  debug        = false,
  log          = vim.fn.stdpath "state" .. "/noice.log",
  log_max_size = 1024 * 1024 * 2,

  -- you can enable a preset for easier configuration
  presets = {
    bottom_search         = false, -- use a classic bottom cmdline for search
    command_palette       = true,  -- position the cmdline and popupmenu together
    long_message_to_split = false, -- long messages will be sent to a split
    inc_rename            = false, -- enables an input dialog for inc-rename.nvim
    lsp_doc_border        = true,  -- add a border to hover docs and signature help
  },

  lsp = {
    -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
    override = {
      ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      ["vim.lsp.util.stylize_markdown"] = true,
      ["cmp.entry.get_documentation"] = true,
    },
    progress  = { enable = false },
    hover     = { enable = false },
    message   = { enable = false },
    signature = { enable = false },
  },

  noitfy    = { enable = false },
  cmdline   = { enable = false },
  popupmenu = { enable = true },
  redirect  = {},
  commands  = {},
  notify    = {},
  markdown  = {},
  health    = {},
  throttle  = 1000 / 30,
  status    = {},
  format    = {},

  messages = {
    -- Using kevinhwang91/nvim-hlslens because virtualtext is hard to read
    view_search = false,
  },

  routes = {
    -- Show @recording messages
    -- https://github.com/folke/noice.nvim/wiki/Configuration-Recipes#show-recording-messages
    {
      view   = "notify",
      filter = { event = "msg_showmode" },
      opts   = { skip = true },
    },
    -- Hide written messages
    -- https://github.com/folke/noice.nvim/wiki/Configuration-Recipes#hide-written-messages
    {
      filter = { event = "msg_show", kind  = "", find  = "written" },
      opts   = { skip = true },
    },
    -- Hide Search Virtaual Text
    -- https://github.com/folke/noice.nvim/wiki/Configuration-Recipes#hide-search-virtual-text
    {
      filter = { event = "msg_show", kind  = "search_count" },
      opts   = { skip = true },
    },
  },

  -- https://github.com/folke/noice.nvim/wiki/Configuration-Recipes#display-the-cmdline-and-popupmenu-together
  views = {
    cmdline_popup = {
      position = { row = vim.o.lines * 0.32, col = "50%" },
      size     = { width = 60, height = "auto" },
    },
    popupmenu = {
      relative = "editor",
      position = { row = 8, col = "50%" },
      size     = { width = 60, height = 10 },
      border   = { style = "rounded", padding = { 0, 1 }},
    },
    win_options = {
      winhighlight = { Normal = "Normal", FloatBorder = "DiagnosticInfo" },
    },
    notiify = {
      backend = { "snacks", "notify" },
    },
  },
})
