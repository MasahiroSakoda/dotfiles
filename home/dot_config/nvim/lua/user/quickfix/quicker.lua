-- -*-mode:lua-*- vim:ft=lua
local ok, quicker = pcall(require, "quicker")
if not ok then return end

quicker.setup({
  opts = {
    buflisted  = true,
    number     = true,
    signcolumn = "auto",
  },
  highlight = {
    treesitter   = true,
    lsp          = false,
    load_buffers = false,
  },
  max_filename_width = function()
    return math.floor(math.min(45, vim.o.columns / 2))
  end,
})

local palette = require("onedark.palette")[vim.g.themestyle]
vim.api.nvim_set_hl(0, "QuickFixHeaderHard", { fg = palette.light_grey })
vim.api.nvim_set_hl(0, "QuickFixLineNr",     { fg = palette.bg_yellow  })
