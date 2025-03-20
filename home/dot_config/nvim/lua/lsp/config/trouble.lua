local ok, trouble = pcall(require, "trouble")
if not ok then return end

trouble.setup({
  debug = false,
  auto_close    = false, -- auto close when there are no items
  auto_open     = false, -- auto open when there are items
  auto_preview  = true,  -- automatically open preview when on an item
  auto_refresh  = true,  -- auto refresh when open
  auto_jump     = false, -- auto jump to the item when there's only one
  focus         = true,  -- Focus the window when opened
  restore       = true,  -- restores the last location in the list when opening
  follow        = true,  -- Follow the current item
  indent_guides = true,  -- show indent guides
  max_items     = 200,   -- limit number of items that can be displayed per section
  multiline     = true,  -- render multi-line messages
  pinned        = false, -- When pinned, the opened trouble window will be bound to the current buffer

  warn_no_results = false, -- show a warning when there are no results
  open_no_results = true,  -- open the trouble window when there are no results
  win = {},                -- window options for the results window. Can be a split or a floating window.
  preview = { type = "main", scratch = true },
  throttle = {},

  modes = {
    diagnostics = {
      win = { position = 'bottom' },
      preview = {
        type     = 'split',
        relative = 'win',
        position = 'right',
        size = 0.35,
      },
    },
    symbols = {
      win = { position = 'right', size = 0.25 },
      preview = {
        type     = 'split',
        relative = 'win',
        position = 'bottom',
        size = 0.35,
      },
    },
    lsp = {
      win = { position = 'bottom' },
    },
    qflist = {
      win = { position = 'bottom' },
      preview = {
        type     = 'split',
        relative = 'win',
        position = 'right',
        size = 0.35,
      },
    },
  },

  picker = {
    actions = require("trouble.sources.snacks").actions,
    win = {
      input = {
        keys = { ["<c-t>"] = { "trouble_open", mode = { "n", "i" } } },
      },
    },
  },

  keys = {
    ["?"]     = "help",
    ["ESC"]   = "cancel",
    ["<c-s>"] = "jump_split",
    ["<c-v>"] = "jump_vsplit",

    ["{"]  = "prev",
    ["[["] = "prev",
    ["}"]  = "next",
    ["]]"] = "next",

    i = "inspect",
    p = "preview",
    P = "toggle_preview",
  },

  icons = {},
})
