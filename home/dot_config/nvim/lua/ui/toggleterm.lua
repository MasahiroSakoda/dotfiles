local ok, tt = pcall(require, "toggleterm")
if not ok then return end

local o = vim.o

tt.setup({
  direction = "float", ---@Usage "vertical", "horizontal", "tab", "float"
  close_on_exit= true,
  shell = o.shell,

  highlights = {
    FloatBorder = {
      guifg = "#a3ff00",
      guibg = "#6600ff",
    },
  },
  float_opts = {
    width  = function() return math.ceil(o.columns * 0.85) end,
    -- height = function() return math.ceil(o.columns * 0.4) end,
    border   = "curved", ---@Usage "single", "double", "shadow", "curved"
    winblend = 20,
  },
})
