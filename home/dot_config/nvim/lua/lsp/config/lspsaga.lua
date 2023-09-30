local ok, lspsaga = pcall(require, "lspsaga")
if not ok then return end

lspsaga.setup({
  ui = {
    boader  = "single",
    devicon = true,
    code_action = "󰌶",
    diagnostic  = "",
    expand      = "",
    collapse    = "",
    hover       = " ",
  },

  preview = {
    lines_above = 0,
    lines_below = 10,
  },

  scroll_preview = {
    scroll_down = "<C-f>",
    scroll_up = "<C-b>",
  },

  symbol_in_winbar = {
    enable    = false,
    show_file = false,
  },

  lightbulb = {
    enable = false,
  },

  code_action = {
    show_server_name = true,
    keys = {
      quit = { "<ESC>", "q" },
      exec = "<CR>",
    },
  },

  rename = {
    quit      = "<C-c>",
    exec      = "<CR>",
    confirm   = "<CR>",
    in_select = true,
  },

  finder = {
    max_height = 0.5,
    min_width  = 30,
    force_max_height = false,
    keys = {
      quit = { "q", "<ESC>" },
      split  = "h",
      vsplit = "v",
      tabe = "t",
      jump_to = "p",
      expand_or_jump = "o",
      close_in_preview = "<ESC>",
      scroll_down = "<C-f>",
      scroll_up   = "<C-b>", -- quit can be a table
    },
  },

  hover = {
    max_width = 0.5,
    open_link = "gx",
    -- open_browser = "!chrome",
    open_browser = "!brave",
  },

  outline = {
    auto_close   = true,
    auto_refresh = true,
    auto_preview = true,
    win_width    = 30,
    win_position = "right",
    layout = "normal",
    keys = {
      expand_or_jump = "o",
      quit = "q",
    },
  },

})

-- lspsaga.setup({
--   -- Appearance
--   border_style = "single",
--   symbol_in_winbar = {
--     enable     = false, -- Disable to use nvim-navic
--     show_icons = true,
--     show_file  = true,
--     folder_level = 3,
--   },
--   code_action_lightbulb = {
--     enable = true,
--   },
--   saga_winblend = 5,
--   move_in_saga  = {
--     prev = "<C-p>",
--     next = "<C-n>",
--   },
--
--   show_outline = {
--     win_position = "right",
--     win_with     = "",
--     win_width    = 30,
--     auto_enter   = true,
--     auto_preview = true,
--     virt_text = "┃",
--     jump_key  = "o",
--     auto_refresh = true,
--   },
--
--   diagnostic_header = { " ", " ", " ", "ﴞ " },
--   max_preview_lines = 10,
--
--   definition_action_keys = {
--     quit   = "<ESC>",
--     edit   = "<C-c>o",
--     vsplit = "<C-c>v",
--     split  = "<C-c>i",
--     tabe   = "<C-c>t",
--   },
--
--   -- Code Action
--   code_action_icon = "◆ ",
--   code_action_num_shortcut = true,
--   code_action_keys = {
--     quit = "<ESC>",
--     exec = "<CR>",
--   },
--
--   -- Finder
--   finder_icons = { def  = " ", ref  = "諭", link = " " },
--   finder_request_timeout = 1500,
--   finder_action_keys = {
--     open   = "o",
--     vsplit = "v",
--     split  = "h",
--     tabe   = "t",
--     tabnew = "n",
--     quit   = "<ESC>",
--     scroll_up   = "<C-f>",
--     scroll_down = "<C-b>",
--   },
--
--   rename_action_quit = "<C-c>",
--   rename_in_select = true,
--
--   server_filetype_map = {
--     -- typescript = "typescript"
--   },
--
--   callhierarchy = {
--     show_detail = true,
--     keys = {
--       edit   = "e",
--       vsplit = "v",
--       split  = "h",
--       tabe   = "t",
--       jump   = "o",
--       quit   = "q",
--       expand_collapse = "u",
--     },
--   },
-- })
