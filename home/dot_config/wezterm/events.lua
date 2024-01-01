-- -*-mode:lua-*- vim:ft=lua
local wezterm = require("wezterm")
local utils   = require("utils")
local schemes = require("theme").color_schemes
local scheme  = wezterm.color.get_builtin_schemes()[schemes[wezterm.GLOBAL.color_scheme_index]]
local fg, bg  = scheme.foreground, scheme.background
local edge_fg, edge_bg = bg, scheme.background
local fonts   = wezterm.nerdfonts

-- wezterm.on("gui-startup", function(cmd)
--   local _, _, window = wezterm.mux.spawn_window(cmd or {})
--   window.gui_window():toggle_fullscreen()
-- end)

wezterm.on("format-window-title", function(tab, _, tabs, _, _)
  local index = ''
  if #tabs > 1 then
    index = string.format('[%d/%d] ', tab.tab_index + 1, #tabs)
  end

  return index .. ": " .. tab.active_pane.title
end)

wezterm.on("format-tab-title", function(tab, _, _, _, _, max_width)
  local process   = tab.active_pane.foreground_process_name
  local icon      = utils.process_icon(process)
  local tab_title = wezterm.truncate_right(utils.basename(process), max_width)
  local index_bg  = tab.is_active and scheme.brights[5] or scheme.ansi[1]

  return {
    { Attribute  = { Intensity = "Bold" } },
    { Foreground = { Color = edge_fg } },
    { Background = { Color = index_bg } },
    { Text       = fonts.cod_chevron_left },
    { Attribute  = { Underline = "Curly" } },
    { Foreground = { Color = fg } },
    { Background = { Color = index_bg } },
    { Text       = tab.tab_index + 1 .. ":" .. icon .. tab_title },
    { Foreground = { Color = edge_fg } },
    { Background = { Color = index_bg } },
    { Text       = fonts.cod_chevron_right },
    { Attribute = { Intensity = "Normal" } },
  }
end)

wezterm.on("update-status", function(window, _)
  window:set_left_status(wezterm.format({
    { Foreground = { Color = scheme.brights[7] } },
    { Background = { Color = scheme.ansi[1] } },
    { Text = "[" .. window:active_workspace() .. "]" },
  }))
  window:set_right_status(wezterm.format({
    { Foreground = { Color = scheme.brights[6] } },
    { Background = { Color = scheme.ansi[1] } },
    { Text = utils.active_key_status(window) },
    { Foreground = { Color = scheme.brights[3] } },
    { Background = { Color = scheme.ansi[1] } },
    { Text = utils.keyboard_status(window) },
    { Foreground = { Color = scheme.brights[4] } },
    { Background = { Color = scheme.ansi[1] } },
    { Text = utils.date() },
    { Foreground = { Color = scheme.ansi[7] } },
    { Background = { Color = scheme.ansi[1] } },
    { Text = utils.time() },
  }))
end)

wezterm.on("window-config-reloaded", function(window, _)
  window:toast_notification("wezterm", "Configuration reloaded.", nil , 5000)
end)

wezterm.on("switch-colorscheme", function(window, _)
  local overrides = window:get_config_overrides() or {}

  if not overrides.color_scheme then
    if wezterm.GLOBAL.color_scheme_index < #schemes then
      wezterm.GLOBAL.color_scheme_index = wezterm.GLOBAL.color_scheme_index + 1
    else
      wezterm.GLOBAL.color_scheme_index = 0
    end
    overrides.color_scheme = schemes[wezterm.GLOBAL.color_scheme_index]
  else
    overrides.color_scheme = nil
  end

  window:set_config_overrides(overrides)
end)

wezterm.on("switch-background-image", function(window, _)
  local overrides = window:get_config_overrides() or {}
  local images = require("background")
  if not overrides.background then
    if wezterm.GLOBAL.color_scheme_index < #images then
      wezterm.GLOBAL.background_index = wezterm.GLOBAL.background_index + 1
    else
      wezterm.GLOBAL.background_index = 0
    end
    overrides.background = images[wezterm.GLOBAL.background_index]
  else
    overrides.background = nil
  end

  window:set_config_overrides(overrides)
end)

wezterm.on("increate-opacity", function(window, _)
  local overrides = window.get_config_overrides() or {}
  overrides.window_background_opacity = math.min(1, overrides.window_background_opacity + 0.05)
  window:set_config_overrides(overrides)
end)

wezterm.on("decreate-opacity", function(window, _)
  local overrides = window.get_config_overrides() or {}
  overrides.window_background_opacity = math.max(0, overrides.window_background_opacity - 0.05)
  window:set_config_overrides(overrides)
end)
