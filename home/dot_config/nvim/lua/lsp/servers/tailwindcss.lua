-- -*-mode:lua-*- vim:ft=lua

---@type vim.lsp.Config
return {
  cmd          = { "tailwindcss-language-server", "--stdio" },
  filetypes    = {
    "html", "css", "scss",
    "javascript", "javascriptreact", "typescript", "typescriptreact",
    "vue", "svelte", "templ",
  },
  root_markers = require("user.filetypes").lsp.tailwindcss,

  settings = {
    tailwindCSS = {
      validate = true,
      lint = {
        cssConflict           = "warning",
        invalidApply          = "error",
        invalidScreen         = "error",
        invalidVariant        = "error",
        invalidConfigPath     = "error",
        recommendVariantOrder = "warning",
      },
      classAttributes  = { "class", "className", "class:list", "classList", "ngClass" },
      classFunctions   = { "cva", "cx", "tw", "twMerge" },
      includeLanguages = { templ = "html" },
    },
  },
  workspace_required = true,
}
