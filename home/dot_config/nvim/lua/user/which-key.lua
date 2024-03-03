local ok, wk = pcall(require, "which-key")
if not ok then
  vim.notify('Failed loading ' .. "which-key", vim.log.levels.ERROR)
end

wk.setup({
  presets = {
    nav = true,
  },
  window = {
    border   = "double",
    margin   = { 1, 2, 1, 2 }, -- extra window margin [top, right, bottom, left]
    padding  = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
    winblend = 25,
  },
  layout = {
    spacing = 2,
    align   = "center",
		width  = { min = 5, max = 50 }, -- min and max width of the columns
    height = { min = 10, max = 25 }, -- min and max height of the columns
  },
  disable = {
    buftypes  = {},
    filetypes = { "TelescopePrompt" },
  },
})
