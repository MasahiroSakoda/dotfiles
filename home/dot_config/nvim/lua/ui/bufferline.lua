local ok, bufferline = pcall(require, "bufferline")
if not ok then return end

local palette = require("onedark.palette")[vim.g.themestyle]

bufferline.setup({
  options = {
    mode        = "tabs",     ---@type "tabs"|"buffers"
    diagnostics = "nvim_lsp", ---@type "nvim_lsp"|"coc"

    -- Format
  ---@param buf table<string, any>
    name_formatter = function(buf)
      return buf.name:match("%.md") and vim.fn.fnamemodify(buf.name, ":t:r") or buf.name
    end,
  ---@param opts table<string, any>
    numbers        = function(opts) return string.format("%s", opts.ordinal) end,

    -- Size / Length
    tab_size          = 21,
    max_name_length   = 21,
    max_prefix_length = 18,

    separator_style        = "slope", ---@type "slope"|"slant"|"padded_slant"|"thick"|"thin"
    enforce_regular_tabs   = false,
    always_show_bufferline = true,

    -- Icon
    color_icons       = true,
    show_buffer_icons = true,
    show_close_icons  = true,
    show_buffer_close_icon   = true,

    close_icon         = "",
    buffer_close_icon  = "",
    modified_icon      = "●",
    left_trunc_marker  = "",
    right_trunc_marker = "",
    -- close_command      = "Bdelete %d",
    -- right_mouse_command = "Bdelete! %d",

    -- diagnostics_indicator = function(count, level, diagnostics_dict, context)
    --   local icon = level:match("error") and " " or " "
    --   return "" .. icon .. count
    -- end,

    indicator = { icon  = "| ", style = "underline" },

    -- Hover
    hover = { enabled = true, delay   = 150, reveal  = { "close" } },
  },

  highlights = {
    separator          = { fg = palette.bg1, bg = palette.black },
    separator_selected = { fg = palette.bg1 },
    background         = { fg = palette.light_grey, bg = palette.black },
    buffer_selected    = { fg = "#fdf6e3", bold = true, italic = true },
    fill               = { bg = palette.bg1 }
  },
})
