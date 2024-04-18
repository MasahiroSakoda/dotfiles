local ok, fidget = pcall(require, "fidget")
if not ok then return end

fidget.setup({

  progress = {
    suppress_on_insert   = false,
    ignore_done_already  = true,
    ignore_empty_message = true,
    ignore = { -- List of LSP Server to ignore
      "null-ls",
    },

    display = {
      render_limit = 10,
      progress_icon = {
        { pattern = "grow_vertical", period = 1 },
      },
      overrides = {
        rust_analyzer = { name = "rust-analyzer" },
      },
    },
  },

  notification = {
    view = {
      group_separator = "----------",
    },
    window = {
      winblend   = 45,
      border     = "none", --- @type "none"|"single"|"double"|"rounded"|"solid"|"shadow"
      max_width  = 0,
      max_height = 0,
      x_padding  = 1,
      y_padding  = 0,
      align    = "bottom", --- @type "top"|"bottom"|"avoid_cursor"
      relative = "editor", --- @type "editor"|"win"
    },
  },
})
