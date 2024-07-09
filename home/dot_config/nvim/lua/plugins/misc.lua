-- -*-mode:lua-*- vim:ft=lua

return {
  -- chezmoi integration
  {
    "xvzc/chezmoi.nvim",
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function() require("user.chezmoi") end,
  },
  {
    "stevearc/overseer.nvim",
    cmd = { "OverseerToggle", "OverseerRun" },
    config = function() require("user.overseer") end,
  },
  -- Translate Engine
  { "potamides/pantran.nvim", cmd = "Pantran", config = function() require("user.pantran") end },

  {
    "epwalsh/obsidian.nvim",
    version = "*",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
    cmd = {
      "ObsidianOpen", "ObsidianExtractNote", "ObsidianNew", "ObsidianWorkspace",
      "ObsidianLink", "ObsidianLinkNew", "ObsidianFollowLink", "ObsidianBacklinks",
      "ObsidianDailies", "ObsidianToday", "ObsidianTomorrow", "ObsidianYesterday",
      "ObsidianSearch", "ObsidianQuickSwitch", "ObsidianRename", "ObsidianTags",
      "ObsidianTemplate", "ObsidianPasteImg", "ObsidianToggleCheckbox",
    },
    config = function() require("user.obsidian") end,
  },
}
