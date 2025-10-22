local ok, comment = pcall(require, "Comment")
if not ok then return end

-- to skip backwards compatibility routines and speed up loading
vim.g.skip_ts_context_commentstring_module = true

comment.setup({
  padding   = true,
  sticky    = true,
  ignore    = "^$",

  toggler   = { line = "gcc", block = "gbc" },
  opleader  = { line = "gc", block = "gb" },
  extra     = { above = "gcO", below = "gco", eol = "gcA" },
  mappings  = { basic = true, extra = true },

  pre_hook  = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
  post_hook = function() end,
})

-- Workaround overlapping with `gb` & `gc`: numToStr/Comment.nvim#483
vim.keymap.del("n", "gb")
vim.keymap.del("n", "gc")

require("which-key").add({
  { "gb", group = "Toggle comment blockwise", icon = " " },
  { "gc", group = "Toggle comment linewise",  icon = " " },
})
