local ok, rd = pcall(require, "rainbow-delimiters")
if not ok then return end

vim.g.rainbow_delimiters = {
  strategy = {
    [''] = rd.strategy["global"],
    vim  = rd.strategy["local"],
  },
  query = {
    [""]       = "rainbow-delimiters",
    lua        = "rainbow-blocks",
    latex      = "rainbow-blocks",
    javascript = "rainbow-parens",
    typescript = "rainbow-parens",
    tsx        = "rainbow-parens",
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
}
