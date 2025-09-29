local ok, rd = pcall(require, "rainbow-delimiters.setup")
if not ok then return end

rd.setup({
  strategy = {
    [""] = "rainbow-delimiters.strategy.global",
    vim  = "rainbow-delimiters.strategy.local",
  },
  query = {
    [""]       = "rainbow-delimiters",
    lua        = "rainbow-blocks",
    latex      = "rainbow-blocks",
    javascript = "rainbow-delimiters-react",
    typescript = "rainbow-parens",
    tsx        = "rainbow-tags-react",
  },
  highlight = {
    "RainbowDelimiterRed",
    "RainbowDelimiterYellow",
    "RainbowDelimiterBlue",
    "RainbowDelimiterOrange",
    "RainbowDelimiterGreen",
    "RainbowDelimiterViolet",
    "RainbowDelimiterCyan",
  },
  blacklist = {
    "c", "cpp",
  },
})
