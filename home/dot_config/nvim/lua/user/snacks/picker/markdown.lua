-- -*-mode:lua-*- vim:ft=lua

---@type snacks.picker.Config
return {
  finder  = "files",
  format  = "file",
  -- preview = "preview",
  args    = {
    "-e", "md",
    "-e", "mdx",
    "-e", "markdown",
    "-e", "wiki",
  },
  -- Add a custom icon and name for the picker
  prompt = "   ",
}
