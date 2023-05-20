local ok, fidget = pcall(require, "fidget")
if not ok then return end

fidget.setup({
  window = {
    blend    = 35,
    relative = "win",
  },
  text = {
    -- Available spinner: earth, moon, grow_vertical, meter, dots_pulse
    spinner = "dots_pulse",
  },
  timer = {
    fidget_decay = 2500,
    task_decay   = 1500,
  },
  align = {
    bottom = true,
    right  = true,
  },
})
