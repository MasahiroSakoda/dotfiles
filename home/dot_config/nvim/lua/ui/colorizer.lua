local ok, colorizer = pcall(require, "colorizer")
if not ok then return end

-- Use the `default_options` as the second parameter, which uses
-- `foreground` for every mode. This is the inverse of the previous
-- setup configuration.
colorizer.setup({
  filetypes = {
    "*",
    "!lazy",
    "!noice",
    -- "lua", "css",
  },
  buftype = { "*", "!prompt", "!nofile" },
  user_default_options = {
    names    = false, -- "Name" codes like Blue
    RRGGBBAA = true,  -- #RRGGBBAA hex codes
    AARRGGBB = true, -- 0xAARRGGBB hex codes
    rgb_fn   = true,  -- CSS rgb() and rgba() functions
    hsl_fn   = true,  -- CSS hsl() and hsla() functions
    css      = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
    css_fn   = true,  -- Enable all CSS *functions*: rgb_fn, hsl_fn
    ---@Usage Available modes for `mode`: foreground, background,  virtualtext
    mode = "virtualtext", -- Set the display mode.
    virtualtext = "■■",
  }
})
