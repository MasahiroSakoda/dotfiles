-- -*-mode:lua-*- vim:ft=lua
local ft = require("user.filetypes")

---@type vim.lsp.Config
return {
  cmd          = { "tombi", "lsp" },
  filetype     = { "toml" },
  root_markers = ft.lsp.tombi,
}
