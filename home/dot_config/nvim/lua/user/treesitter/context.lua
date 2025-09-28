-- -*-mode:lua-*- vim:ft=lua
local ok, context = pcall(require, "treesitter-context")
if not ok then return end

context.setup({
  enable      = true,
  multiwindow = false,

  max_lines           = 0,
  min_window_height   = 0,
  line_numbers        = true,
  multiline_threshold = 20,

  trim_scope = "outer",
  mode       = "cursor",

  separator = nil,
  zindex    = 20,
  on_attach = nil,
})

require("which-key").add({
  { "gx", function() context.go_to_context(vim.v.count1) end, mode = "n", icon = "󰆾 ", desc = "Go to context" },
}, { noremap = true })
