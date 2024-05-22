-- -*-mode:lua-*- vim:ft=lua
local ok, obsidian = pcall(require, "obsidian")
if not ok then return end

local doc_dir = vim.fn.expand("$HOME") .. "/Documents"
local template_dir = "999_Templates"

obsidian.setup({
  workspaces = {
    { name = "notes", path = doc_dir .. "Obsidian Vault" },
  },
  daily_notes = {
    folder = "001_DailyNotes",
    template = template_dir .. "/Daily/dailyNoteTemplate.md",
  },
  templates   = {
    subdir = template_dir,
    substitutions = {
      today     = function() return os.date("%Y-%m-%d", os.time()) end,
      yesterday = function() return os.date("%Y-%m-%d", os.time() - 86400) end,
      tomorrow  = function() return os.date("%Y-%m-%d", os.time() + 86400) end,
    }
  },

})
