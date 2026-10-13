require("obsidian").setup({
  legacy_commands = false,
  workspaces = {
    { name = "Personal", path = vim.fn.expand("~/Documents/Obsidian Vault") },
  },
  new_notes_location = "current_dir",
  notes_subdir = "",
  daily_notes = {
    folder      = "daily",
    date_format = "%Y-%m-%d",
    template    = "daily.md",
  },
  ui     = { enable = false },
  picker = { name = "snacks.picker" },
})
