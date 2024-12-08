-- -*-mode:lua-*- vim:ft=lua
local ok, gitsigns = pcall(require, "gitsigns")
if not ok then return end

gitsigns.setup({
  current_line_blame = true,
  signs = {
    add          = { text = "┃" },
    change       = { text = "┃" },
    delete       = { text = "_" },
    topdelete    = { text = "‾" },
    changedelete = { text = "~" },
    untracked    = { text = "┆" },
  },
})
