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
  -- Start hidden and wait for a key to be pressed before showing the popup
  -- defer    = function(ctx)
  --   return vim.list_contains({ "d", "y" }, ctx.operator) or vim.list_contains({ "V", "<C-V>" }, ctx.mode)
  -- end,

  plugins = {
    marks     = true, -- shows a list of your marks on ' and `
    registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode

    presets = {
      operators    = true, -- adds help for operators like d, y, ...
      motions      = true, -- adds help for motions
      text_objects = true, -- help for text objects triggered after entering an operator
      windows      = true, -- default bindings on <c-w>
      nav          = true, -- misc bindings to work with windows
      z            = true, -- bindings for folds, spelling and others prefixed with z
      g            = true, -- bindings for prefixed with g
    },
  },
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
