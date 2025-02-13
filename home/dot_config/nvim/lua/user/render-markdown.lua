-- -*-mode:lua-*- vim:ft=lua
local ok, rm = pcall(require, "render-markdown")
if not ok then return end

rm.setup({
  file_types   = { "markdown", "vimwiki", "codecompanion" },
})
