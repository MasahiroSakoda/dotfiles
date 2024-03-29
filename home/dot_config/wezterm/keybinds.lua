-- -*-mode:lua-*- vim:ft=lua
local wezterm = require("wezterm")
local pattern = require("regexp").pattern
local act     = wezterm.action

-- See https://wezfurlong.org/wezterm/config/keys.html
return {
  -- See https://wezfurlong.org/wezterm/config/lua/keyassignment/index.html
  keys = {
    -- Application
    { key = "q", mods = "SUPER", action = act.QuitApplication },
    { key = "h", mods = "SUPER", action = act.HideApplication },
    { key = "m", mods = "SUPER", action = act.Hide },
    { key = "r", mods = "SUPER", action = act.ReloadConfiguration },
    { key = "k", mods = "SUPER", action = act.ClearScrollback("ScrollbackAndViewport") },
    { key = "p", mods = "SUPER", action = act.ActivateCommandPalette },

    -- Fullscreen
    { key = "Enter", mods = "SUPER",      action = act.ToggleFullScreen },
    { key = "f",     mods = "SUPER|CTRL", action = act.ToggleFullScreen },

    -- Window
    { key = "n", mods = "SUPER", action = act.SpawnWindow },
    { key = "n", mods = "SUPER", action = act.SpawnWindow },

    -- Tab
    { key = "t",   mods = "SUPER",      action = act.SpawnTab("CurrentPaneDomain") },
    { key = "w",   mods = "SUPER",      action = act.CloseCurrentTab({ confirm = false }) },
    { key = "Tab", mods = "CTRL",       action = act.ActivateTabRelative(1) },
    { key = "Tab", mods = "CTRL|SHIFT", action = act.ActivateTabRelative(-1) },
    -- { key = "p",   mods = "LEADER",     action = act.ActivateTabRelative(-1) },
    -- { key = "n",   mods = "LEADER",     action = act.ActivateTabRelative(1) },
    { key = "1",   mods = "SUPER",      action = act.ActivateTab(0) },
    { key = "2",   mods = "SUPER",      action = act.ActivateTab(1) },
    { key = "3",   mods = "SUPER",      action = act.ActivateTab(2) },
    { key = "4",   mods = "SUPER",      action = act.ActivateTab(3) },
    { key = "5",   mods = "SUPER",      action = act.ActivateTab(4) },
    { key = "6",   mods = "SUPER",      action = act.ActivateTab(5) },
    { key = "7",   mods = "SUPER",      action = act.ActivateTab(6) },
    { key = "8",   mods = "SUPER",      action = act.ActivateTab(7) },
    { key = "9",   mods = "SUPER",      action = act.ActivateLastTab },

    -- Pane
    { key = "d", mods = "SUPER", action = act.SplitHorizontal },
    { key = "D", mods = "SUPER", action = act.SplitVertical },
    { key = "W", mods = "SUPER", action = act.CloseCurrentPane({ confirm = false }) },
    { key = "[", mods = "SUPER", action = act.RotatePanes("CounterClockwise") },
    { key = "]", mods = "SUPER", action = act.RotatePanes("Clockwise") },
    { key = "LeftArrow",  mods = "SUPER", action = act.ActivatePaneDirection("Left") },
    { key = "RightArrow", mods = "SUPER", action = act.ActivatePaneDirection("Right") },
    { key = "UpArrow",    mods = "SUPER", action = act.ActivatePaneDirection("Up") },
    { key = "DownArrow",  mods = "SUPER", action = act.ActivatePaneDirection("Down") },

    -- Font
    { key = "+", mods = "SUPER",       action = act.IncreaseFontSize },
    { key = "+", mods = "SUPER|SHIFT", action = act.IncreaseFontSize },
    { key = "-", mods = "SUPER",       action = act.DecreaseFontSize },
    { key = "-", mods = "SUPER|SHIFT", action = act.DecreaseFontSize },
    { key = "0", mods = "SUPER",       action = act.ResetFontSize },
    { key = "0", mods = "LEADER",      action = act.EmitEvent("toggle-ligature") },

    -- Opacity
    { key = "F1", mods = "SHIFT", action = act.EmitEvent("decrease-opacity") },
    { key = "F2", mods = "SHIFT", action = act.EmitEvent("increase-opacity") },

    -- Colro Scheme
    { key = "c", mods = "LEADER", action = act.EmitEvent("switch-colorscheme") },

    -- Background Image
    { key = "b", mods = "LEADER", action = act.EmitEvent("switch-background-image") },

    -- Search
    { key = "f", mods = "SUPER", action = act.Search("CurrentSelectionOrEmptyString") },

    -- Clipboard
    { key = "c",     mods = "SUPER",  action = act.CopyTo("Clipboard") },
    { key = "v",     mods = "SUPER",  action = act.PasteFrom("Clipboard") },
    -- Copy Mode https://wezfurlong.org/wezterm/copymode.html
    { key = "y",     mods = "SUPER",  action = act.ActivateCopyMode },

    -- Quick Select
    { key = "s", mods = "SUPER|CTRL", action = act.QuickSelect },
    {
      key = "l",
      mods = "SUPER|CTRL",
      action = act.QuickSelectArgs({ label = "Copy Line", patterns = { pattern.line } })
    },
    {
      key = "i",
      mods = "SUPER|CTRL",
      action = act.QuickSelectArgs({ label = "Copy IP address", patterns = { pattern.ipv4, pattern.ipv6 } })
    },
    {
      key = "S",
      mods = "SUPER|CTRL",
      action = act.QuickSelectArgs({ label = "Copy hash", patterns = { pattern.hash } })
    },
    {
      key = "u",
      mods = "SUPER|CTRL",
      action = act.QuickSelectArgs({ label = "Copy URL", patterns = { pattern.http } })
    },
    {
      key = "o",
      mods = "SUPER|CTRL",
      action = act.QuickSelectArgs({
        label = "Open URL with default browser",
        patterns = { pattern.http },
        action = wezterm.action_callback(function(window, pane)
          local url = window:get_selection_text_for_pane(pane)
          wezterm.log_info("Opening: " .. url)
          wezterm.open_with(url)
        end)
      })
    },

    { key = "m", mods = "LEADER", action = act.ActivateKeyTable({ name = "manage_pane" }) },
    { key = "r", mods = "LEADER", action = act.ActivateKeyTable({ name = "resize_pane", one_shot = false }) },
  },
  -- See https://wezfurlong.org/wezterm/config/lua/keyassignment/CopyMode/index.html
  key_tables = {
    copy_mode = {
      { key = "Escape", mods = "NONE", action = act.Multiple({
        act.CopyMode("Close"),
        act.CopyMode("ClearSelectionMode"),
      }) },

      { key = "/", mods = "NONE", action = act.Multiple({
        act.CopyMode("ClearPattern"),
        act.Search({ CaseSensitiveString = "" }),
      }) },
      { key = "n", mods = "NONE", action = act.Multiple({
        act.CopyMode("PriorMatch"),
        act.CopyMode("ClearSelectionMode"),
      }) },
      { key = "N", mods = "SHIFT", action = act.Multiple({
        act.CopyMode("NextMatch"),
        act.CopyMode("ClearSelectionMode"),
      }) },
      { key = "Enter",  mods = "NONE", action = act.CopyMode("MoveToStartOfNextLine") },

      -- Move
      { key = "0", mods = "NONE",  action = act.CopyMode("MoveToStartOfLineContent") },
      { key = "^", mods = "NONE",  action = act.CopyMode("MoveToStartOfLineContent") },
      { key = "^", mods = "SHIFT", action = act.CopyMode("MoveToStartOfLineContent") },
      { key = "$", mods = "NONE",  action = act.CopyMode("MoveToEndOfLineContent") },
      { key = "$", mods = "SHIFT", action = act.CopyMode("MoveToEndOfLineContent") },

      { key = "H", mods = "NONE",  action = act.CopyMode("MoveToViewportTop") },
      { key = "H", mods = "SHIFT", action = act.CopyMode("MoveToViewportTop") },
      { key = "L", mods = "NONE",  action = act.CopyMode("MoveToViewportBottom") },
      { key = "L", mods = "SHIFT", action = act.CopyMode("MoveToViewportBottom") },
      { key = "M", mods = "NONE",  action = act.CopyMode("MoveToViewportMiddle") },
      { key = "M", mods = "SHIFT", action = act.CopyMode("MoveToViewportMiddle") },
      { key = "w", mods = "NONE",  action = act.CopyMode("MoveForwardWord") },
      { key = "b", mods = "NONE",  action = act.CopyMode("MoveBackwardWord") },
      { key = "b", mods = "SHIFT", action = act.CopyMode("MoveBackwardWord") },
      { key = "g", mods = "NONE",  action = act.CopyMode("MoveToScrollbackTop") },
      { key = "G", mods = "NONE",  action = act.CopyMode("MoveToScrollbackBottom") },
      { key = "G", mods = "SHIFT", action = act.CopyMode("MoveToScrollbackBottom") },

      { key = "v", mods = "NONE",  action = act.CopyMode({ SetSelectionMode = "Cell" }) },
      { key = "v", mods = "CTRL",  action = act.CopyMode({ SetSelectionMode = "Block" }) },
      { key = "V", mods = "NONE",  action = act.CopyMode({ SetSelectionMode = "Line" }) },
      { key = "V", mods = "SHIFT", action = act.CopyMode({ SetSelectionMode = "Line" }) },

      {
        key = "y",
        mods = "NONE",
        action = act.Multiple{{ CopyTo = "ClipboardAndPrimarySelection" }, { CopyMode = "Close" } },
      },

      { key = "k", mods = "SUPER", action = act.ClearScrollback("ScrollbackOnly") },
      { key = "K", mods = "CTRL",  action = act.ClearScrollback("ScrollbackOnly") },
    },
    search_mode = {
      { key = "Enter",  mods = "SHIFT", action = act.CopyMode("PriorMatch")},
      { key = "Enter",  mods = "NONE",  action = act.CopyMode("NextMatch")},
      { key = "Escape", mods = "NONE",  action = act.Multiple({
        act.CopyMode("ClearSelectionMode"),
        act.CopyMode("Close"),
      }) },

      { key = "n", mods = "CTRL",  action = act.CopyMode("NextMatch") },
      { key = "p", mods = "CTRL",  action = act.CopyMode("PriorMatch") },
      { key = "r", mods = "CTRL",  action = act.CopyMode("CycleMatchType") },
      { key = "u", mods = "CTRL",  action = act.CopyMode("ClearPattern") },
    },
    manage_pane = {
      { key = "w", action = act.PaneSelect },
      { key = "q", action = act.CloseCurrentPane({ confirm = true }) },
      { key = "h", action = act.ActivatePaneDirection("Left") },
      { key = "l", action = act.ActivatePaneDirection("Right") },
      { key = "k", action = act.ActivatePaneDirection("Up") },
      { key = "j", action = act.ActivatePaneDirection("Down") },
      { key = "H", action = act.SplitPane({ direction = "Left" }) },
      { key = "L", action = act.SplitPane({ direction = "Right" }) },
      { key = "K", action = act.SplitPane({ direction = "Up" }) },
      { key = "J", action = act.SplitPane({ direction = "Down" }) },

    },
    resize_pane = {
      { key = "h",      action = act.AdjustPaneSize({ "Left", 5 }) },
      { key = "l",      action = act.AdjustPaneSize({ "Right", 5 }) },
      { key = "j",      action = act.AdjustPaneSize({ "Down", 5 }) },
      { key = "k",      action = act.AdjustPaneSize({ "Up", 5 }) },
      { key = "Escape", action = act.PopKeyTable },
    },
  },
}
