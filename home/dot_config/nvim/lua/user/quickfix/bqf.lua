-- -*-mode:lua-*- vim:ft=lua
local ok, bqf = pcall(require, "nvim-bqf")
if not ok then return end

bqf.setup({
  auto_enable        = true,
  auto_resize_height = true,

  preview = {
    auto_preview = false,
    winblend     = 0,
    win_height   = 10,
    win_vheight  = 10,
    delay_syntax = 80,
    border       = { '┃', '┃', '━', '━', '┏', '┓', '┗', '┛', '█' },
    show_title   = false,

    should_preview_cb = function(bufnr, _)
      local bufname = vim.api.nvim_buf_get_name(bufnr)
      return vim.fn.getfsize(bufname) > 100 * 1024 and false or true
    end,
  },


  filter = {
    fzf = {
      action_for = { ["ctrl-s"] = "split", ["ctrl-t"] = "tabdrop" },
      extra_opts = { "--bind", "ctrl-o:toggle-all", "--delimiter", "│", "--prompt", "" },
    },
  },
  func_map = {
    fzffilter = "/",
    drop      = "o",
    openc     = "O",
    split     = "<C-h>",
    vsplit    = "<C-s>",
    tabdrop   = "<C-t>",
  },
})

local palette = require("onedark.palette")[vim.g.themestyle]
vim.api.nvim_set_hl(0, "BqfPreviewBorder", { ctermbg = palette.dark_cyan, fg =  palette.fg })
vim.api.nvim_set_hl(0, "BqfPreviewTitle",  { ctermbg = palette.dark_cyan, fg =  palette.fg })
vim.api.nvim_set_hl(0, "BqfPreviewThumb",  { ctermbg = palette.dark_cyan, fg =  palette.fg })
vim.api.nvim_set_hl(0, "BqfPreviewRange",  { link = "Search" })
