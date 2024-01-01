-- -*-mode:lua-*- vim:ft=lua
local wezterm = require("wezterm")
local fonts   = wezterm.nerdfonts
local M = {}

M.basename = function(s)
  return string.gsub(s, "(.*[/\\])(.*)", "%2")
end

M.datetime = function()
  local datetime = wezterm.strftime("%b %d (%a) %H:%M")
  return fonts.fa_clock_o .. " " .. datetime
end

M.date = function()
  local date = wezterm.strftime("%b %-d (%a)")
  return fonts.pl_right_soft_divider .. " " .. fonts.fa_calendar .. "  " .. date .. " "
end

M.time = function()
  local time = wezterm.strftime("%H:%M")
  return fonts.pl_right_soft_divider .. " " .. fonts.fa_clock_o .. "  " .. time .. " "
end

M.battery_percentage = function()
  local battery = ""
  local icon    = ""
  for _, b in ipairs(wezterm.battery_info()) do
    local charge = b.state_of_charge * 100
    if charge <= 10 then
      icon = fonts.md_battery_alert
    elseif charge > 10 and charge <= 30 then
      icon = fonts.md_battery_20
    elseif charge > 30 and charge <= 50 then
      icon = fonts.md_battery_40
    elseif charge > 50 and charge <= 70 then
      icon = fonts.md_battery_60
    elseif charge > 70 and charge <= 90 then
      icon = fonts.md_battery_80
    else
      icon = fonts.md_battery
    end
    battery = icon .. " " .. string.format("%.0f%%", charge)
  end
  return battery
end

M.keyboard_status = function(window)
  local icon = window:composition_status() and "あ" or "abc"
  return fonts.pl_right_soft_divider .. " " .. icon .. " "
end

M.active_key_status = function(window)
  local status = window:active_key_table() and window:active_key_table() or (window:leader_is_active() and fonts.fa_toggle_on or fonts.fa_toggle_off)
  return fonts.pl_right_soft_divider .. " " .. status .. "  "
end

return M
