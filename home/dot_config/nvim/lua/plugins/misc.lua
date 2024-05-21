-- -*-mode:lua-*- vim:ft=lua

return {
  -- chezmoi integration
  {
    "xvzc/chezmoi.nvim",
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function() require("user.chezmoi") end,
  },
  -- Translate Engine
  { "potamides/pantran.nvim", cmd = "Pantran", config = function() require("user.pantran") end },

  { "vim-denops/denops.vim" },
  -- Markdown Previewer
  {
    "kat0h/bufpreview.vim",
    dependencies = { "vim-denops/denops.vim" },
    build = "deno task prepare",
    ft    = "markdown",
    cmd   = "PreviewMarkdown",
  },
  {
    "epwalsh/obsidian.nvim",
    version = "*",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
    ft  = "markdown",
    cmd = {
      "ObsidianOpen", "ObsidianExtractNote", "ObsidianNew", "ObsidianWorkspace",
      "ObsidianLink", "ObsidianLinkNew", "ObsidianFollowLink", "ObsidianBacklinks",
      "ObsidianDailies", "ObsidianToday", "ObsidianTomorrow", "ObsidianYesterday",
      "ObsidianSearch", "ObsidianQuickSwitch", "ObsidianRename", "ObsidianTags",
    },
    config = function() require("user.obsidian") end,
  },
}
