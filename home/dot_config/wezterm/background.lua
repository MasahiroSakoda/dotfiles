-- -*-mode:lua-*- vim:ft=lua
local wezdir = os.getenv("HOME") .. "/.config/wezterm"

return {
  {
    source = {
      Gradient = {
        orientation = "Horizontal",
        colors = {
          "#00000C",
          "#000026",
          "#00000C",
        },
        interpolation = "CatmullRom",
        blend = "Rgb",
        noise = 0,
      },
    },
    width   = "100%",
    height  = "100%",
    opacity = 0.85,
  },
  {
    source = {
      Gradient = {
        orientation = "Vertical",
        colors = {
          "#222222",
          "#222233",
          "#222222",
        },
        interpolation = "CatmullRom",
        blend = "Rgb",
        noise = 0,
      }
    },
    width   = "100%",
    height  = "100%",
    opacity = 0.75,
  },
  -- {
  --   source = {
  --     File = {
  --       path = wezdir .. "assets/background.png",
  --     },
  --   },
  --   opacity  = 1.0,
  --   hsb      = { brightness = 0.025 },
  --   width    = "100%",
  --   repeat_x = "NoRepeat",
  --   repeat_x_size = "",
  --   repeat_y = "NoRepeat",
  --   repeat_y_size = "",
  --   horizontal_offset = 0,
  --   vertical_offset   = 0,
  -- },
}
