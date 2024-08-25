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
      left_top        = "╭",
      left_bottom     = "╰",
      right_arrow     = "─",
    },
    style = {
      { fg = "#00ffff" },
      { fg = "#c21f30" }, -- this fg is used to highlight wrong chunk
    },
    delay = 50,
  },
  indent = {
    enable = true,
    chars = { "│", "¦", "┆", "┊", },
  },
})
