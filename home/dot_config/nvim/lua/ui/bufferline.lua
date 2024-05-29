local ok, bufferline = pcall(require, "bufferline")
if not ok then return end

bufferline.setup {
  options = {
    -- Usable mode: tabs / buffers
    mode = "tabs",
    ---@Usable diagnostics: nvim_lsp / coc
    diagnostics = "nvim_lsp",

    -- Format
    name_formatter = function(opts) return string.format("%s", opts.name) end,
    numbers        = function(opts) return string.format("%s", opts.ordinal) end,

    offset = {
      {
        filetype   = "neo-tree",
        highlight  = "Directory",
        text       = "File Explorer",
        text_align = "center",
        separator  = true,
      },
    },

    -- Size / Length
    tab_size = 15,
    max_name_length = 14,
    max_prefix_length = 13,

    ---@Usable style: slant / padded_slant / thick / thin
    separator_style = 'slope',
    enforce_regular_tabs = false,
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

    indicator = {
      icon  = "| ",
      style = "underline",
    },

    -- Hover
    hover = {
      enabled = true,
      delay   = 150,
      reveal  = {'close'}
    },
  },

  highlights = {
    separator = {
      fg = '#073642',
      bg = '#002b36',
    },
    separator_selected = {
      fg = '#073642',
    },
    background = {
      fg = '#657b83',
      bg = '#002b36',
    },
    buffer_selected = {
      fg = '#fdf6e3',
      bold   = true,
      italic = true,
    },
    fill = {
      bg = '#073642'
    }
  },
}
