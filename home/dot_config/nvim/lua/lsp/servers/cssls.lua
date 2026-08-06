---@type vim.lsp.Config
return {
  cmd          = { "css-language-server", "--stdio" },
  filetypes    = { "css", "scss", "less" },
  root_markers = { "package.json", ".git" },

  settings = {
    css  = { validate = true },
    scss = { validate = true },
    less = { validate = true },
  },
}

-- -*-mode:lua-*- vim:ft=lua
