-- -*-mode:lua-*- vim:ft=lua

---@type vim.lsp.Config
return {
  cmd          = { "vscode-css-language-server", "--stdio" },
  filetypes    = { "css", "scss", "less" },
  root_markers = { "package.json", ".git" },

  settings = {
    css  = { validate = true },
    less = { validate = true },
    scss = { validate = true },
  }
}
