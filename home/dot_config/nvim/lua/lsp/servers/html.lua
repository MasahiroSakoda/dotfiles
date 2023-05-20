local ok, lspconfig = pcall(require, "lspconfig")
if not ok then return end

return {
  cmd       = { "html-languageserver", "--stdio" },
  filetypes = { "html", "eruby" },
  root_dir  = lspconfig.util.root_pattern("package.json"),
  single_file_support = true,
  init_options = {
    provideFormatter = true,
    embeddedLanguages = { css = true, javascript = true },
    configurationSection = { "html", "css", "javascript" },
  },
  setrings = {},
}
