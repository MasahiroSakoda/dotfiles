local ok, wk = pcall(require, "which-key")
if not ok then
  vim.notify('Failed loading ' .. "which-key", vim.log.levels.ERROR)
end

wk.setup({
  preset = "modern", ---@type "classic"|"modern"|"helix"
  win = {
    no_overlap = true,
    padding = { 1, 2 }, -- extra window padding [top/bottom, right/left]
    title     = true,
    title_pos = "center",
    bo = {},
    wo = {
      winblend = 25,
    },
  },
  layout = {
    spacing = 3,
    align   = "center", ---@type "left"|"right"|"center"
		width  = { min = 5, max = 50 }, -- min and max width of the columns
  },
  disable = {
    buftypes  = {},
    filetypes = { "fzf" },
  },
})
