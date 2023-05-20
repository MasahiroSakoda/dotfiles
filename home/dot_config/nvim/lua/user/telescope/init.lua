local ok, telescope = pcall(require, "telescope")
if not ok then return end

local actions    = require "telescope.actions"
local layout     = require "telescope.actions.layout"
local fb_actions = require "telescope._extensions.file_browser.actions"

local fn, cmd = vim.fn, vim.cmd
local db_root = fn.stdpath("state")

local find_command = { "fd", "--type", "f", "--hidden", "--follow", "--exclude", "{.git,node_modules}" }
local grep_command = { "rg", "--follow", "--hidden", "--color=never", "--no-heading", "--with-filename", "--line-number", "--column", "--smart-case", "--trim" }

local borderchars = {
  prompt  = {'▀', '▐', '▄', '▌', '▛', '▜', '▟', '▙' },
  results = {' ', '▐', '▄', '▌', '▌', '▐', '▟', '▙' },
  preview = {'▀', '▐', '▄', '▌', '▛', '▜', '▟', '▙' },
}

telescope.setup({
  defaults = {
    vimgrep_arguments = grep_command,
    prompt_prefix = '🔍  ',
    selection_caret = " ",
    color_devicons = true,
    layout_config    = {
      width  = 0.75,
      preview_width = 0.5,
      prompt_position = "top",    ---@Usage: "top", "bottom"
    },
    borderchars = borderchars,
    sorting_strategy = "ascending", ---@Usage "ascending", "descending"
    winblend = 20,
    file_ignore_patterns = {
      "build/", "dist/",
      "build/", "%.o", "%.out", "%.a", "%.d", "%.so",        -- Binary
      "%.tar", "%.tar.gz", "%.zip", "%.rar", "%.7z", -- Archives
      "^./.git/", ".github/", ".gitignore", -- Git
      "%.otf", "%.ttf", "%.woff", ".fonts", -- font
      "%.ico", "%.svg", -- Icon
      "^.idea/", "^.vscode/", -- IDE
      ".DS_Store", "%.dylib", -- macOS
      "%.exe", "Thumbs.db",   -- Windows

      "%.class", "%.jar", "%.war", -- Java
      "%.dll", "%.pdb", -- C#
      "^node_modules/", "package-lock.json", "yarn.lock", -- Node.js
      "%.min.js", "%.min.gzip.js", -- JavaScript & TypeScript
      "__pycache__/*", "__pycache__/", "%.ipynb", -- Python
      "^vendor/", "^deps/", "Gemfile.lock", -- Ruby
      "%.sqlite3", "%.db", -- Database

      "%.ai", "%.psd", -- Illustrator / Photoshop
      "%.jpg", "%.jpeg", "%.png", "%.webp", -- Image
      "%.mp4", "%.mkv", "%.m4v", -- Video
      "%.wav", "%.flac", "ttf", "%.mp3", -- Audio
      "%.docx", "%.xlsx", "%.pptx", "%.pdf", "%.epub", -- Documents
      "themepack/",
      ".terraform",
      "lazy-lock.json",
    },
    mappings = {
      n = {
        ["q"]     = actions.close,
        ["<ESC>"] = actions.close,
        ["<C-c>"] = actions.close,
        ["<CR>"]  = actions.select_default,
        ["<C-t>"] = actions.select_tab,
        ["<C-x>"] = actions.select_horizontal,
        ["<C-v>"] = actions.select_vertical,
        ["<C-b>"] = actions.results_scrolling_up,
        ["<C-f>"] = actions.results_scrolling_down,
        ["u"]     = actions.move_selection_previous,
        ["e"]     = actions.move_selection_next,
        ["gg"]    = actions.move_to_top,
        ["M"]     = actions.move_to_middle,
        ["G"]     = actions.move_to_bottom,
        ["<C-/>"] = actions.which_key,
      },
      i = {
        ["<C-c>"] = actions.close,
        ["<CR>"]  = actions.select_default,
        ["<C-t>"] = actions.select_tab,
        ["<C-v>"] = actions.select_vertical,
        ["<C-s>"] = actions.select_horizontal,
        ["<C-b>"] = actions.results_scrolling_up,
        ["<C-f>"] = actions.results_scrolling_down,
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-j>"] = actions.move_selection_next,
        ["<C-u>"] = actions.preview_scrolling_up,
        ["<C-d>"] = actions.preview_scrolling_down,
        ["<C-p>"] = layout.toggle_preview,
        ["<C-o>"] = layout.toggle_mirror,
        ["<C-x>"] = false,
        ["<C-/>"] = actions.which_key,
      },
    },
  },

  pickers = {
    find_files = {
      -- theme  = "dropdown",
      hidden = true,
      files  = true,
      find_command = find_command,
    },
    live_grep = {
      file_ignore_patterns = { "^.git/", "%.lock" },
    },
    file_browser = {
      hidden = true,
      files  = true,
      find_command = find_command,
    },
    frecency = {
      hidden = true,
      files  = true,
    },
    lazy = {
      show_icon = true,
      mappings = {
        open_in_browser           = "<C-o>",
        open_in_file_browser      = "<C-z>",
        open_in_find_files        = "<C-f>",
        open_in_live_grep         = "<C-p>",
        open_plugins_picker       = "<C-g>", -- Works only after having called first another action
        open_lazy_root_find_files = "<C-r>f",
        open_lazy_root_live_grep  = "<C-r>g",
      },
    },
  },

  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = "smart_case", ---@Usage case_mode: smart_case / respect_case
    },

    file_browser = {
      layout_strategy  = "horizontal",
      hijack_netrw = true,
      -- Keymap
      mappings = {
        ["n"] = {
          -- your custom normal mode mappings
          ["N"] = fb_actions.create,
          ["h"] = fb_actions.goto_parent_dir,
          ["/"] = function()
            cmd('startinsert')
          end,
        },
        ["i"] = {
          -- your custom insert mode mappings
          ["<C-w>"] = function() cmd('normal vbd') end,
        },
      },
      history = { path = db_root .. "/databases/telescope_history.sqlite3", limit = 100 },
    },

    frecency = {
      default_workspace = "CWD",
      db_root = db_root,
      db_safe_mode     = true,
      auto_validate    = true,
      show_scores      = true,
      show_unindexed   = true,
      disable_devicons = false,
      ignore_patterns  = { "*.git/*", "*/tmp/*", "*/node_modules/*" },
      show_filter_column = { "LSP", "CWD", "VIM" },
      workspaces = {
        ["fish"]    = "~/.config/fish",
        ["nvim"]    = "~/.config/nvim",
        ["lazy"]    = "~/.local/share/nvim/lazy",
        ["project"] = "~/Dev",
        ["doc"]    = "~/Documents",
      },
    },
  }
})

-- Load Extensions
telescope.load_extension("fzf")
telescope.load_extension("frecency")
telescope.load_extension("file_browser")
telescope.load_extension("notify")
