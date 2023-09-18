local ok, neogen = pcall(require, "neogen")
if not ok then return end

neogen.setup({
  enable = true,
  snippet_engine = "luasnip",
})
