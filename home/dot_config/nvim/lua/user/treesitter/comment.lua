local ok, comment = pcall(require, "Comment")
if not ok then return end

-- to skip backwards compatibility routines and speed up loading
vim.g.skip_ts_context_commentstring_module = true

comment.setup({
  pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),

  -- Ignore empty lines
  ignore = "^$",
})
