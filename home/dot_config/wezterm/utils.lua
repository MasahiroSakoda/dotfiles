-- -*-mode:lua-*- vim:ft=lua
local wezterm = require("wezterm")
local fonts   = wezterm.nerdfonts
local M = {}

M.basename = function(s)
  return string.gsub(s, "(.*[/\\])(.*)", "%2")
end

M.process_icon = function(foreground_process)
  local icons = {
    bash    = fonts.cod_terminal_bash,
    fish    = fonts.md_fish,
    nvim    = fonts.custom_vim,
    ssh     = fonts.mdi_server,
    top     = fonts.mdi_monitor,
    btm     = fonts.mdi_monitor,
    tmux    = fonts.cod_terminal_tmux,
    tree    = fonts.cod_list_tree,
    aria2c  = fonts.md_cloud_download_outline,
    curl    = fonts.md_cloud_download_outline,
    wget    = fonts.md_cloud_download_outline,
    rsync   = fonts.md_cloud_sync,
    git     = fonts.dev_git,
    lazygit = fonts.dev_git,
    gh      = fonts.dev_github_badge,
    docker  = fonts.dev_docker,
    kubectl = fonts.linux_docker,
    kuberlr = fonts.linux_docker,
    aws     = fonts.dev_aws,
    cargo   = fonts.dev_rust,
    go      = fonts.seti_go,
    lua     = fonts.seti_lua,
    make    = fonts.seti_makefile,
    cmake   = fonts.seti_makefile,
    erlang  = fonts.dev_erlang,
    node    = fonts.dev_nodejs_small,
    npm     = fonts.dev_npm,
    pnpm    = fonts.dev_npm,
    deno    = fonts.md_nodejs,
    bun     = fonts.md_nodejs,
    python  = fonts.dev_python,
    pip     = fonts.dev_python,
    ruby    = fonts.dev_ruby,
    bundle  = fonts.dev_ruby,
    sqlite  = fonts.dev_sqlite,
    default = fonts.cod_terminal,
  }
  local process = M.basename(foreground_process)
  return icons[process] and icons[process] .. " " or icons["default"] .. " "
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
