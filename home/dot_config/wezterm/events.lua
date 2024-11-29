-- -*-mode:lua-*- vim:ft=lua
local wezterm = require("wezterm")
local utils   = require("utils")
local schemes = require("theme").color_schemes
local scheme  = wezterm.color.get_builtin_schemes()[schemes[wezterm.GLOBAL.color_scheme_index]]
local fg, bg  = scheme.foreground, scheme.background
local edge_fg, edge_bg = bg, scheme.background

wezterm.on("gui-startup", function(cmd)
  local _, _, window = wezterm.mux.spawn_window(cmd or {})
  window:gui_window():toggle_fullscreen()
end)

wezterm.on("format-window-title", function(tab, _, tabs, _, _)
  local index = #tabs > 1 and string.format("[%d/%d] ", tab.tab_index + 1, #tabs) or ""
  return index .. ": " .. tab.active_pane.title
end)

wezterm.on("format-tab-title", function(tab, _, _, _, _, max_width)
  local process   = tab.active_pane.foreground_process_name
  local icon      = utils.process_icon(process)
  local tab_title = wezterm.truncate_right(utils.basename(process), max_width)

  local tab_fg = tab.is_active and fg or scheme.brights[4]
  local tab_bg = tab.is_active and scheme.brights[5] or edge_fg

  return {
    -- Tab index
    { Attribute  = { Intensity = tab.is_active and "Bold" or "Normal" } },
    { Foreground = { Color = fg } },
    { Background = { Color = tab_bg } },
    { Text       = tab.tab_index + 1 .. ":" },
    -- Process icon
    { Attribute = { Intensity = "Bold" } },
    { Foreground = { Color = tab.is_active and scheme.brights[1] or scheme.ansi[5] } },
    { Background = { Color = tab_bg } },
    { Text       = icon .. " " },
    -- Tab title
    { Attribute  = { Underline = "Curly" } },
    { Foreground = { Color = tab_fg } },
    { Background = { Color = tab_bg } },
    { Text       = tab_title .. " " },
  }
end)

wezterm.on("update-status", function(window, _)
  window:set_left_status(wezterm.format({
    { Attribute  = { Intensity = "Bold" } },
    { Foreground = { Color = scheme.ansi[4] } },
    { Background = { Color = edge_bg } },
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

wezterm.on("increase-opacity", function(window, _)
  local overrides = window.get_config_overrides() or {}
  overrides.window_background_opacity = math.min(1, overrides.window_background_opacity + 0.05)
  window:set_config_overrides(overrides)
end)

wezterm.on("decrease-opacity", function(window, _)
  local overrides = window.get_config_overrides() or {}
  overrides.window_background_opacity = math.max(0, overrides.window_background_opacity - 0.05)
  window:set_config_overrides(overrides)
end)

wezterm.on("toggle-ligature", function(window, _)
  local overrides = window.get_config_overrides() or {}
  overrides.harfbuzz_features = not overrides.harfbuzz_features and { "calt=0", "alig=0", "liga=0" } or nil
  window:set_config_overrides(overrides)
end)
