require("render-markdown").setup({
  file_types   = { "markdown", "vimwiki" },
  render_modes = { "n", "c", "t" },
  code         = { border = "thick" },
  completions  = {
    blink = { enabled = true },
    lsp   = { enabled = true },
  },
  latex        = {
    enabled    = true,
    converter  = "latex2text",
    highlight  = "RenderMarkdownMath",
    top_pad    = 0,
    bottom_pad = 0,
  },
})
