local fn, api = vim.fn, vim.api

-- Color Schemes
---@Usage for nightfox: nightfox/dayfox/dawnfox/duskfox/nordfox/terafox/carbonfox
---@Usage for tokyonight: tokyonight-night/tokyonight-storm/tokyonight-day/tokyonight-moon

-- Disable changing color scheme cause by this segment
-- https://blog.atusy.net/2022/12/17/styler-nvim-active-win/
--- @type "nightfox"|"dayfox"|"dawnfox"|"duskfox"|"nordfox"|"carbonfox"
local ACTIVE_COLORSCHEME   = "nightfox"
--- @type "nightfox"|"dayfox"|"dawnfox"|"duskfox"|"nordfox"|"carbonfox"
local INACTIVE_COLORSCHEME = "carbonfox"
vim.cmd.colorscheme(ACTIVE_COLORSCHEME)

local styler_ok, styler = pcall(require, "styler")
if not styler_ok then return end

local inactivate = function(win)
  -- skip for certain situations
  if not api.nvim_win_is_valid(win) then return end
  if api.nvim_win_get_config(win).relative ~= "" then return end

  -- apply colorscheme if not yet
  if (vim.w[win].theme or {}).colorscheme ~= INACTIVE_COLORSCHEME then
    styler.set_theme(win, { colorscheme = INACTIVE_COLORSCHEME })
  end
end

api.nvim_create_autocmd({ "WinLeave", "WinNew" }, {
  group = api.nvim_create_augroup('styler-custom', {}),
  desc  = 'Change theme by the path of the current buffer.',
  callback = function(_)
    local win_event = api.nvim_get_current_win()
    vim.schedule(function()
      local win_pre    = fn.win_getid(fn.winnr("#"))
      local win_cursor = vim.api.nvim_get_current_win()
      -- カーソル位置のウィンドウでstyler.nvimを無効化する
      if (vim.w[win_cursor].theme or {}).colorscheme then
        styler.clear(win_cursor)
      end
      -- 直前のウィンドウにカーソルがなければinactivate
      if win_pre ~= 0 and win_pre ~= win_cursor then
        inactivate(win_pre)
      end
      -- イベントを発行したウィンドウにカーソルがなければinactivate
      if win_event ~= win_cursor then
        inactivate(win_event)
      end
    end)
  end
})
