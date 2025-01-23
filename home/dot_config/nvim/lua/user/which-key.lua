local ok, wk = pcall(require, "which-key")
if not ok then
  vim.notify('Failed loading ' .. "which-key", vim.log.levels.ERROR)
end

wk.setup({
  debug     = false,
  show_help = true,
  show_keys = true,

  preset   = "modern", ---@type "classic"|"modern"|"helix"
  delay    = function(ctx) return ctx.plugin and 0 or 200 end,
  filter   = function(_) return true end,
  spec     = {},
  notify   = true,
  triggers = { "<auto>", "nxso" },
  defer    = function(ctx) return ctx.mode == "V" or ctx.mode == "<C-V>" end,

  plugins = {},
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
  keys    = {},
  sort    = {},
  expand  = 0,
  replace = {},
  icons   = {},
  disable = {
    buftypes  = {},
    filetypes = { "fzf" },
  },
})
