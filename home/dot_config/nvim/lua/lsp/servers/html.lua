-- -*-mode:lua-*- vim:ft=lua

---@type vim.lsp.Config
return {
  cmd          = { "vscode-html-language-server", "--stdio" },
  filetypes    = require("user.filetypes").lang.html,
  root_markers = { "package.json", ".git" },
  single_file_support = true,
  init_options = {
    provideFormatter = true,
    embeddedLanguages = { css = true, javascript = true },
    configurationSection = { "html", "css", "javascript" },
  },
  setrings = {},
}
