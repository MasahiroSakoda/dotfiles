local ok, lspsaga = pcall(require, "lspsaga")
if not ok then return end

lspsaga.setup({
  ui = {
    boader  = "single",
    devicon = true,
    title   = false,
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

  -- configud in lualine.nvim
  symbol_in_winbar = {
    enable    = false,
    show_file = false,
  },

  implement = {
    enable = false,
    sign   = true,
    virtual_text = true,
  },

  -- configured in rainbow-delimiters.nvim
  lightbulb = {
    enable = false,
  },

  diagnostic = {
    on_insert         = false,
    jump_num_shortcut = true,
    show_source       = false,
    show_code_action  = false,
    show_virt_line    = false,
    keys = {
      quit        = { "<C-c>", "q" },
      exec_action = { "<CR>", "o" },
      go_action   = "g",
    },
  },

  -- configured in  fidget.nvim
  code_action = {
    show_server_name = false,
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
