local ok, bqf = pcall(require, "bqf")
if not ok then return end

bqf.setup({
  auto_enable = true,
  auto_resize_height = true, -- highly recommended enable
  preview = {
    auto_preview = false,
    win_height   = 12,
    win_vheight  = 12,
    delay_syntax = 80,
    border_chars = { '┃', '┃', '━', '━', '┏', '┓', '┗', '┛', '█' },
  },
  func_map = {
    fzffilter = '/',
    split     = '<C-s>',
  },
  filter = { -- Adapt fzf's delimiter in nvim-bqf
    fzf = {
      extra_opts = {'--bind', 'alt-a:toggle-all', '--delimiter', '│'}
    }
  },
})
