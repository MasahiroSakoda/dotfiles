-- -*-mode:lua-*- vim:ft=lua

---@type vim.lsp.Config
return {
  cmd          = { "vscode-html-languageserver", "--stdio" },
  filetypes    = { "html", "eruby" },
  root_markers = { "package.json", ".git" },
  single_file_support = true,
  init_options = {
    provideFormatter = true,
    embeddedLanguages = { css = true, javascript = true },
    configurationSection = { "html", "css", "javascript" },
  },
  setrings = {},
}
