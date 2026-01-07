-- -*-mode:lua-*- vim:ft=lua

local ok, oil = pcall(require, "oil")
if not ok then return end

local detailed_columns = true
local columns          = detailed_columns and { "icon", "permissions", "size", "mtime" } or { "icon", "size" }
local width, height    = vim.api.nvim_get_option_value("columns", {}), vim.api.nvim_get_option_value("lines", {})

oil.setup({
  default_file_explorer = true,

  columns = columns,

  win_options = {
    wrap = true,
    winblend = 15,
  },

    -- Skip the confirmation popup for simple operations (:help oil.skip_confirm_for_simple_edits)
  skip_confirm_for_simple_edits = true,

  view_options = {
    show_hidden   = true,
    natural_order = true,
    is_always_hidden = function(name, _)
      return vim.tbl_contains(require("core.ignore").oil, name)
    end
  },

  float = {
    border     = "rounded",
    max_width  = math.floor(width * 0.85),
    max_height = math.floor(height * 0.8),
  },

  use_default_keymaps = true,
  keymap = {
    ["g?"]    = { "actions.show_help",   mode = "n" },
    ["gs"]    = { "actions.change_sort", mode = "n" },
    ["<C-c>"] = { "actions.close",       mode = "n" },
    ["<CR>"]  =   "actions.select",
    ["<C-l>"] =   "actions.refresh",
    ["<C-p>"] =   "actions.preview",
    ["<C-u>"] =   "actions.preview_scroll_up",
    ["<C-d>"] =   "actions.preview_scroll_down",
    ["<C-s>"] = { "actions.select", opts = { vertical = true } },
    ["<C-h>"] = { "actions.select", opts = { horizontal = true } },
    ["<C-t>"] = { "actions.select", opts = { tab = true } },
    ["-"]     = { "actions.parent", mode = "n" },
    ["_"]     = { "actions.open_cwd", mode = "n" },
    ["`"]     = { "actions.cd", mode = "n" },
    ["~"]     = { "actions.cd", opts = { scope = "tab" }, mode = "n" },
    ["g."]    = { "actions.toggle_hidden", mode = "n" },
    ["g,"]    =   "actions.open_external",
  },
})
