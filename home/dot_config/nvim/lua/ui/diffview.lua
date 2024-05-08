-- -*-mode:lua-*- vim:ft=lua
local ok, diffview = pcall(require, "diffview")
if not ok then return end

diffview.setup({
  enhanced_diff_hl = true,
  key_bindings = {
    view = {
      q = "<CMD>DiffviewClose<CR>",
    },
    file_history_panel = {
      q = "<CMD>DiffviewClose<CR>",
    },
    file_panel = {
      q = "<CMD>DiffviewClose<CR>",
    },
  },
})
