-- -*-mode:lua-*- vim:ft=lua
local ft = require("user.filetypes")

---@type vim.lsp.Config
return {
  cmd          = { "texlab" },
  filetypes    = ft.lang.latex,
  root_markers = { ".git" },
  settings = {
    texlab = {
      build = {
        executable = "latexmk",
        args = { "-pdf", "-interaction=nonstopmode", "-synctex=1", "%f" },
        onSave = false,
        forwardSearchAfter = false,
      },
      forwardSearch = { executable = nil, args = {} },
      chktex = { onOpenAndSave = true, onEdit = true },
      diagnosticsDelay = 300,
      latexFormatter = "latexindent",
      latexindent = {
        ["local"] = nil, -- local is a reserved keyword
        modifyLineBreaks = false,
      },
      bibtexFormatter = "texlab",
      formatterLineLength = 80,
    },
  },
  single_file_support = true,
}
