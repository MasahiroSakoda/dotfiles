-- -*-mode:lua-*- vim:ft=lua
local ok, obsidian = pcall(require, "obsidian")
if not ok then return end

local doc_dir = vim.fn.expand("$HOME") .. "/Documents/"
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

  mappings = {
    -- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
    ["gf"] = {
      action = function() return obsidian.util.gf_passthrough() end,
      opts   = { noremap = false, expr = true, buffer = true },
    },
     -- Toggle check-boxes.
    ["<Leader>ch"] = {
      action = function() return obsidian.util.toggle_checkbox() end,
      opts   = { buffer = true },
    },
    -- Smart action depending on context, either follow link or toggle checkbox.
    ["<Leader>oa"] = {
      action = function() return obsidian.util.smart_action() end,
      opts   = { expr = true, buffer = true },
    },
  },
})
