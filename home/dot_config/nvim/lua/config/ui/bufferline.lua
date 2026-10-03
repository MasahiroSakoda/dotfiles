require("bufferline").setup({
  options = {
    mode        = "tabs",     ---@type "tabs"|"buffers"
    diagnostics = "nvim_lsp", ---@type "nvim_lsp"|"coc"

    ---@param opts table<string, any>
    numbers = function(opts) return string.format("%s: ", opts.ordinal) end,

    tab_size          = 21,
    max_name_length   = 21,
    max_prefix_length = 18,

    separator_style        = "slope", ---@type "slope"|"slant"|"padded_slant"|"thick"|"thin"
    enforce_regular_tabs   = false,
    always_show_bufferline = true,

    color_icons       = true,
    show_buffer_icons = true,
    show_close_icons  = true,
    show_buffer_close_icon   = true,

    close_icon         = "",
    buffer_close_icon  = "",
    modified_icon      = "●",
    left_trunc_marker  = "",
    right_trunc_marker = "",

    indicator = { icon  = "| ", style = "underline" },
    hover     = { enabled = true, delay   = 150, reveal  = { "close" } },
  },
})
