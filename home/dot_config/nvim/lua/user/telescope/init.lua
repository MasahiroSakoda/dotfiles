local ok, telescope = pcall(require, "telescope")
if not ok then return end

local actions = require "telescope.actions"
local layout  = require "telescope.actions.layout"

local fd_cmd   = require("core.find")
local rg_cmd   = require("core.grep")
local patterns = require("core.ignore")
local borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" }

local flash = function(prompt_bufnr)
  require("flash").jump({
    pattern = "^",
    label = { after = { 0, 0 } },
    search = {
      mode = "search",
      exclude = {
        function(win)
          return vim.bo[vim.api.nvim_win_get_buf(win)].filetype ~= "TelescopeResults"
        end,
      },
    },
    action = function(match)
      local picker = require("telescope.actions.state").get_current_picker(prompt_bufnr)
      picker:set_selection(match.pos[1] - 1)
    end,
  })
end

telescope.setup({
  defaults = {
    vimgrep_arguments = rg_cmd,
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
    -- file_ignore_patterns = patterns.files,
    path_display = {
      truncate = true,
    },
    dynamic_preview_title = true,
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
        ["s"]     = flash,
      },
      i = {
        ["<C-c>"] = actions.close,
        ["<CR>"]  = actions.select_default,
        ["<C-t>"] = actions.select_tab,
        ["<C-x>"] = actions.select_horizontal,
        ["<C-v>"] = actions.select_vertical,
        ["<C-b>"] = actions.results_scrolling_up,
        ["<C-f>"] = actions.results_scrolling_down,
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-j>"] = actions.move_selection_next,
        ["<C-u>"] = actions.preview_scrolling_up,
        ["<C-d>"] = actions.preview_scrolling_down,
        ["<C-p>"] = layout.toggle_preview,
        ["<C-o>"] = layout.toggle_mirror,
        ["<C-/>"] = actions.which_key,
        ["<C-s>"] = flash,
      },
    },
  },

  pickers = {
    find_files = {
      -- theme  = "dropdown",
      hidden = true,
      files  = true,
      find_command = fd_cmd,
    },
    live_grep = {
      -- file_ignore_patterns = patterns.files,
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

telescope.load_extension("fzf")
