local styler_ok, styler = pcall(require, "styler")
if not styler_ok then return end

styler.setup({
  themes = {
    help     = { colorscheme = "terafox", background = "dark" },
    markdown = { colorscheme = "nightfox" },
  }
})
