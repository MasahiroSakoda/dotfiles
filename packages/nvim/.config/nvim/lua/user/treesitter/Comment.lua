local ok, Comment = pcall(require, "Comment")
if not ok then return end

Comment.setup({
  pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
})
