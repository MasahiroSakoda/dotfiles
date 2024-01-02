-- -*-mode:lua-*- vim:ft=lua
local wezterm  = require("wezterm")
local fonts    = require("fonts")
local keybinds = require("keybinds")
local config   = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- config.default_prog = {
--   "fish", "--login", "--command",
--   "tmux a -t default || tmux new -s default\\; source ~/.config/tmux/default.session.conf",
-- }
config.use_ime = true ---@type boolean
config.status_update_interval = 1000 ---@type integer

--------------------------------------------------
-- Appearance
--------------------------------------------------
config.initial_cols = 100 ---@type integer
config.initial_rows = 25  ---@type integer

-- Theme
wezterm.GLOBAL.color_scheme_index = wezterm.GLOBAL.color_scheme_index or 1
config.color_scheme = require("theme").color_schemes[wezterm.GLOBAL.color_scheme_index]

-- Font
config.font      = fonts.global.font
config.font_size = fonts.global.size + 1
config.adjust_window_size_when_changing_font_size = false ---@type boolean

-- Window
config.window_decorations = "TITLE|RESIZE"
config.window_close_confirmation = "AlwaysPrompt" ---@type "AlwaysPrompt"|"NeverPrompt"

wezterm.GLOBAL.background_index = wezterm.GLOBAL.background_index or 1
config.window_background_image = require("background")[wezterm.GLOBAL.background_index]
config.window_background_opacity = 0.75 ---@type float
config.window_background_image_hsb = {
  brightness = 0.5,
  -- hue = 1.0,
  -- saturation = 1.0,
}
config.window_frame = {
  font      = fonts.window.font,
  font_size = fonts.window.size,
}
config.window_padding = {
  left   = 0, ---@type float
  right  = 0, ---@type float
  top    = 0, ---@type float
  bottom = 0, ---@type float
}
config.native_macos_fullscreen_mode = true ---@type boolean
config.macos_window_background_blur = 10   ---@type integer

-- Tab
config.enable_tab_bar    = true ---@type boolean
config.tab_bar_at_bottom = true ---@type boolean

config.show_tabs_in_tab_bar           = true ---@type boolean
config.show_tab_index_in_tab_bar      = true ---@type boolean
config.show_new_tab_button_in_tab_bar = true ---@type boolean
config.hide_tab_bar_if_only_one_tab   = false ---@type boolean

-- Cursor
config.animation_fps     = 1
config.cursor_blink_rate = 750

---@type "SteadyBlock"|"BlinkingBlock"|"SteadyUnderline"|"BlinkingUnderline"|"SteadyBar"|"BlinkingBar"
config.default_cursor_style  = "BlinkingBlock"
config.cursor_blink_ease_in  = "Constant" ---@type "Constant"|"Linear"
config.cursor_blink_ease_out = "Constant" ---@type "Constant"|"Linear"

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
config.leader = { key = "s", mods = "CTRL", timeout_milliseconds = 1000 }

--------------------------------------------------
-- Hyperlink / Quick Select
--------------------------------------------------
config.hyperlink_rules = require("links")

local select = require("select")
config.quick_select_alphabet = select.alphabet
config.quick_select_patterns = select.patterns

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
