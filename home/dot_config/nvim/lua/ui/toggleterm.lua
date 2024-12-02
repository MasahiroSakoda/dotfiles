local ok, toggleterm = pcall(require, "toggleterm")
if not ok then return end

toggleterm.setup({
  direction = "float", ---@type "vertical"|"horizontal"|"tab"|"float"
  close_on_exit= true,
  shell = vim.o.shell,

  highlights = {
    FloatBorder = {
      guifg = "#a3ff00",
      guibg = "#6600ff",
    },
  },
  float_opts = {
    width  = function() return math.ceil(vim.o.columns * 0.9) end,
    height = function() return math.ceil(vim.o.lines   * 0.9) end,
    border   = "curved", ---@type "single"|"double"|"shadow"|"curved"
    winblend = 20,
  },
})
