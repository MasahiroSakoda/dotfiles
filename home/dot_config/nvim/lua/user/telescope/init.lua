local ok, telescope = pcall(require, "telescope")
if not ok then return end

local actions = require "telescope.actions"
local layout  = require "telescope.actions.layout"

local find_command = require("core.find")
local grep_command = require("core.grep")
local patterns     = require("core.ignore")
local borderchars  = { "─", "│", "─", "│", "┌", "┐", "┘", "└" }

telescope.setup({
  defaults = {
    vimgrep_arguments = grep_command,
    prompt_prefix = '🔍  ',
    selection_caret = " ",
    color_devicons = true,
    layout_config    = {
      width  = 0.9,
      preview_width = 0.5,
      prompt_position = "top",    ---@Usage: "top", "bottom"
    },
    borderchars = {
      prompt = borderchars,
      results = borderchars,
      preview = borderchars,
    },
    sorting_strategy = "ascending", ---@Usage "ascending", "descending"
    winblend = 30,
    file_ignore_patterns = patterns,
    path_display = {
      truncate = true,
    },
    mappings = {
      n = {
        ["q"]     = actions.close,
        ["<C-c>"] = actions.close,
        ["<Tab>"] = actions.toggle_selection,
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
      file_ignore_patterns = patterns,
    },
  },

  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = "smart_case", ---@Usage case_mode: smart_case / respect_case
    },
  }
})
