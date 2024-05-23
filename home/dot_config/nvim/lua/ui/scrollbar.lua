local ok, scrollbar = pcall(require, "scrollbar")
if not ok then return end

local ignore = require("core.ignore")

scrollbar.setup({
  show_in_active_only = true,
  max_lines = false, -- disables if no. of lines in buffer exceeds this
  throttle_ms = 100,

  excluded_buftypes  = ignore.scrollbar.buftypes,
  excluded_filetypes = ignore.scrollbar.filetypes,
  handlers = {
    cursor     = true,
    diagnostic = true,
    gitsigns   = true, -- Requires gitsigns
    handle     = true,
    search     = true, -- Requires hlslens
    ale        = false, -- Requires ALE

  },
})
