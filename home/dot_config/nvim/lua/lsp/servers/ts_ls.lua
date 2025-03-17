local ok, lspconfig = pcall(require, "lspconfig")
if not ok then return end

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

return {
  cmd       = { "typescript-language-server", "--stdio" },
  root_dir  = function (filename)
    return lspconfig.util.root_pattern(
      "jsconfig.json",
      "tsconfig.json",
      "package.json"
    )(filename) or vim.fn.getcwd()
  end,
  autostart = false,
  filetypes = require("user.filetypes").lang.js,

  settings = {
    javascript = settings,
    typescript = settings,
  },
}
