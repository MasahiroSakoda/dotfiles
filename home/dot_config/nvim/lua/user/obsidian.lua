-- -*-mode:lua-*- vim:ft=lua
local ok, obsidian = pcall(require, "obsidian")
if not ok then return end

local doc_dir = vim.fn.expand("$HOME") .. "/Documents/"
local template_dir = "999_Templates"

obsidian.setup({
  workspaces = {
    { name = "notes", path = doc_dir .. "Obsidian Vault" },
  },
  notes_subdir = "002_Notes",
  new_notes_location = "notes_subdir", ---@type "current_dir"|"notes_subdir"
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

  ---@param title string|?
  ---@return string
  note_id_func = function(title)
    return title or tostring(os.date("%Y%m%d-%H%M%S"))
  end,

  ---@param url string
  follow_url_func = function(url)
    if vim.fn.has("mac") then
      vim.fn.jobstart({"open", url})
    elseif vim.fn.executable("xdg-open") then
      vim.fn.jobstart({"xdg-open", url})
    end
  end,
})
