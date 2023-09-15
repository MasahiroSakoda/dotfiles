local ok, telescope = pcall(require, "telescope")
if not ok then return end

telescope.setup({
  pickers = {
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
})
