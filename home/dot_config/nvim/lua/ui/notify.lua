local notify_ok, notify = pcall(require, "notify")
if not notify_ok then return end

local o = vim.o
notify.setup({
  stages = "fade", ---@type "fade"|"slide"|"fade_in_slide_out"|"static"
  ---@usage Function called when a new window is opened, use for changing win settings/config
  on_open = function(win)
    -- Set custom options for the notification windows
    vim.api.nvim_win_set_config(win, {
      focusable = true,
      zindex = 200,
    })
  end,
  ---@usage Function called when a window is closed
  on_close = nil,
  ---@usage timeout for notifications in ms, default 5000
  timeout = 1500,
  ---@usage User render fps value
  fps = 10,
  -- Render function for notifications. See notify-render()
  render = "default",
  ---@usage highlight behind the window for stages that change opacity
  background_colour = "#000000",
  level = "TRACE",

  max_height = function() return math.floor(o.lines * 0.7) end,
  max_width  = function() return math.floor(o.columns * 0.7) end,
})

vim.notify = notify
