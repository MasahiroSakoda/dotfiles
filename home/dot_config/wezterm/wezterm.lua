-- -*-mode:lua-*- vim:ft=lua
local wezterm  = require("wezterm")
local fonts    = require("fonts")
local keybinds = require("keybinds")
local config   = wezterm.config_builder and wezterm.config_builder() or {}

-- config.default_prog = {
--   "fish", "--login", "--command",
--   "tmux a -t default || tmux new -s default\\; source ~/.config/tmux/default.session.conf",
-- }
config.use_ime = true ---@type boolean
config.status_update_interval = 1000 ---@type integer

--------------------------------------------------
-- Appearance
--------------------------------------------------
config.enable_kitty_graphics = true ---@type boolean

config.initial_cols = 200 ---@type integer
config.initial_rows = 80  ---@type integer

-- renderer
config.front_end = "WebGpu"
config.webgpu_power_preference = "LowPower" ---@type "LowPower"|"HighPerformance"

-- Theme
wezterm.GLOBAL.color_scheme_index = wezterm.GLOBAL.color_scheme_index or 1
config.color_scheme = require("theme").color_schemes[wezterm.GLOBAL.color_scheme_index]

-- Font
config.font      = fonts.global.font
config.font_size = fonts.global.size + 1
config.harfbuzz_features = { "calt=1", "alig=1", "liga=1" }
config.adjust_window_size_when_changing_font_size = false ---@type boolean

-- Window
config.window_decorations = "TITLE|RESIZE"
config.window_close_confirmation = "AlwaysPrompt" ---@type "AlwaysPrompt"|"NeverPrompt"

wezterm.GLOBAL.background_index = wezterm.GLOBAL.background_index or 1
config.window_background_image = require("background")[wezterm.GLOBAL.background_index]
config.window_background_opacity = 0.75
config.window_background_image_hsb = {
  brightness = 0.2,
  -- hue = 1.0,
  -- saturation = 1.0,
}
config.window_frame = {
  font      = fonts.window.font,
  font_size = fonts.window.size,
  inactive_titlebar_bg = "none",
  active_titlebar_bg   = "none",
}
config.window_padding = {
  left   = 0,
  right  = 0,
  top    = 0,
  bottom = 0,
}
config.native_macos_fullscreen_mode = true ---@type boolean
config.macos_window_background_blur = 10   ---@type integer

-- Tab
config.enable_tab_bar    = true ---@type boolean
config.tab_bar_at_bottom = true ---@type boolean

config.show_tabs_in_tab_bar           = true ---@type boolean
config.show_tab_index_in_tab_bar      = true ---@type boolean
config.show_new_tab_button_in_tab_bar = true ---@type boolean
config.hide_tab_bar_if_only_one_tab   = true ---@type boolean

-- Cursor
config.animation_fps     = 1
config.cursor_blink_rate = 500

---@type "SteadyBlock"|"BlinkingBlock"|"SteadyUnderline"|"BlinkingUnderline"|"SteadyBar"|"BlinkingBar"
config.default_cursor_style  = "BlinkingBar"
config.cursor_blink_ease_in  = "Constant" ---@type "Constant"|"Linear"
config.cursor_blink_ease_out = "Constant" ---@type "Constant"|"Linear"

config.hide_mouse_cursor_when_typing = true

--------------------------------------------------
-- Scroll
--------------------------------------------------
config.enable_scroll_bar = true  ---@type boolean
config.scrollback_lines  = 10000 ---@type integer

--------------------------------------------------
-- Keybind
--------------------------------------------------
config.enable_kitty_keyboard        = true   ---@type boolean
config.enable_csi_u_key_encoding    = false  ---@type boolean
config.disable_default_key_bindings = true   ---@type boolean

config.keys       = keybinds.keys
config.key_tables = keybinds.key_tables
config.leader = { key = ";", mods = "CTRL", timeout_milliseconds = 2500 }

--------------------------------------------------
-- Hyperlink / Quick Select
--------------------------------------------------
config.hyperlink_rules = require("links")

local select = require("select")
config.quick_select_alphabet = select.alphabet
config.quick_select_patterns = select.patterns

--------------------------------------------------
-- Command Palette
--------------------------------------------------
config.command_palette_font_size = fonts.global.size
config.command_palette_fg_color  = "#cdd6f4"
config.command_palette_bg_color  = "#262626"

--------------------------------------------------
-- Bell
--------------------------------------------------
config.audible_bell = "Disabled"
config.visual_bell  = {
  fade_in_duration_ms  = 75, ---@type integer
  fade_out_duration_ms = 75, ---@type integer
  target = "CursorColor",
}

--------------------------------------------------
-- Event
--------------------------------------------------
require("events")

return config
