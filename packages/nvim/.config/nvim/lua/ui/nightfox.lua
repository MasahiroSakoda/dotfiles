local ok, nf = pcall(require, "nightfox")
if not ok then return end

nf.setup({
  options = {
    styles = {
      comments  = "italic",
      keywords  = "bold",
      functions = "italic",
      types     = "italic,bold",
    }
  }
})
