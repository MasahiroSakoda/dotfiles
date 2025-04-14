-- -*-mode:lua-*- vim:ft=lua
local ok, rm = pcall(require, "render-markdown")
if not ok then return end

rm.setup({
  file_types   = { "markdown", "vimwiki", "codecompanion" },
  render_modes = { "n", "c", "t" },
  code         = { border = "thick" },
  -- latex        = {
  --   enabled    = true,
  --   converter  = "latex2text",
  --   highlight  = "RenderMarkdownMath",
  --   top_pad    = 0,
  --   bottom_pad = 0,
  -- },
})
