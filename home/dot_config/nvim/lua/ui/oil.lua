-- -*-mode:lua-*- vim:ft=lua

local ok, oil = pcall(require, "oil")
if not ok then return end

local width, height = vim.api.nvim_get_option_value("columns", {}), vim.api.nvim_get_option_value("lines", {})

oil.setup({
  columns = {
    "icon",
    -- "permissions",
    "size",
    -- "mtime",
  },

  win_options = {
    wrap = true,
    winblend = 15,
  },

    -- Skip the confirmation popup for simple operations (:help oil.skip_confirm_for_simple_edits)
  skip_confirm_for_simple_edits = true,

  view_options = {
    show_hidden   = true,
    natural_order = true,
    is_always_hidden = function(name, _) return (name == "..") end
  },

  float = {
    border     = "rounded",
    max_width  = math.floor(width * 0.85),
    max_height = math.floor(height * 0.8),
  },

  keymap = {
    ["g?"]    = { "actions.show_help", mode = "n" },
    ["<C-c>"] = { "actions.close",     mode = "n" },
    ["<CR>"]  = "actions.select",
    ["<C-r>"] = "actions.refresh",
    ["<C-p>"] = "actions.preview",
    ["<C-v>"] = { "actions.select", opts = { vertical = true } },
    ["<C-h>"] = { "actions.select", opts = { horizontal = true } },
    ["<C-t>"] = { "actions.select", opts = { tab = true } },
  },
})
