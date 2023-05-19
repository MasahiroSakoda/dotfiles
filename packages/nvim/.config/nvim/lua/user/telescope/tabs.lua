local ok, tabs = pcall(require, "telescope-tabs")
if not ok then return end

tabs.setup({
  theme = "dropdown",
  show_preview = true,
  close_tab_shortcut = "C-d"
})
