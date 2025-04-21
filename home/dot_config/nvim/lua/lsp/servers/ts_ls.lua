-- -*-mode:lua-*- vim:ft=lua

local settings = {
  completions = { completeFunctionCalls = true },
  suggest     = { includeCompletionsForModuleExports = true },
  inlayHints  = {
    includeInlayEnumMemberValueHints = true,
    includeInlayFunctionLikeReturnTypeHints = true,
    includeInlayFunctionParameterTypeHints = true,
    includeInlayParameterNameHints = "all", ---@type "none"|"literals"|"all"
    includeInlayParameterNameHintsWhenArgumentMatchesName = true,
    includeInlayPropertyDeclarationTypeHints = true,
    includeInlayVariableTypeHints = true,
  },
}

---@type vim.lsp.Config
return {
  cmd       = { "typescript-language-server", "--stdio" },
  filetypes = require("user.filetypes").lang.js,
  root_markers = { "package.json", "jsconfig.json", "tsconfig.json", ".git" },
  autostart = false,

  settings = {
    javascript = settings,
    typescript = settings,
  },
}
