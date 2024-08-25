-- -*-mode:lua-*- vim:ft=lua

local ok, hlchunk = pcall(require, "hlchunk")
if not ok then return end

-- https://github.com/shellRaining/hlchunk.nvim#setup
hlchunk.setup({
  chunk = {
    enable = true,
    chars = {
      horizontal_line = "─",
      vertical_line   = "│",
      left_top    = "┌",
      left_bottom = "└",
      right_arrow = "─",
    },
    style = "#00ffff",
  },
  indent = {
    enable = true,
    chars = { "│", "¦", "┆", "┊", },
  },
})
