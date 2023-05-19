local ok, specs = pcall(require, "specs")
if not ok then return end

specs.setup {
  show_jumps  = true,
  min_jump    = 30,
  popup = {
      delay_ms = 0,  -- delay before popup displays
      inc_ms   = 10, -- time increments used for fade/resize effects
      blend    = 10, -- starting blend, between 0-100 (fully transparent), see :h winblend
      width    = 10,
      -- winhl    = "PMenu",
      winhl    = "SpecsH",
      -- fader    = specs.linear_fader,
      -- resizer  = specs.shrink_resizer
      fader    = specs.pulse_fader,
      resizer  = specs.slide_resizer,
  },
  ignore_filetypes = {
  },
  ignore_buftypes = {
      nofile = true,
  },
}
