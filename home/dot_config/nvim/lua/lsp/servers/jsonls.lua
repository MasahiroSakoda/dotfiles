-- -*-mode:lua-*- vim:ft=lua

---@type vim.lsp.Config
return {
  cmd          = { "vscode-json-language-server", "--stdio" },
  filetypes    = require("user.filetypes").lang.json,
  root_markers = { ".git" },
  init_options = { provideFormatter = false, documentRangeFormattingProvide = false },
  single_file_support = true,

  settings = {
    json = {
      schemas = {
        { fileMatch = { "package.json" },  url = "https://www.schemastore.org/package.json" },
        { fileMatch = { "tsconfig.json" }, url = "https://www.schemastore.org/tsconfig.json" },
        { fileMatch = { "turbo.json" },    url = "https://turborepo.com/schema.json" },
        {
          fileMatch = { "renovate.json", "renovate.json5", },
          url = "https://docs.renovatebot.com/renovate-schema.json",
        },
        {
          fileMatch = { "biome.json", "biome.jsonc" },
          url = "https://biomejs.dev/schemas/latest/schema.json",
        },
        {
          fileMatch = { ".prettierrc", ".prettierrc.json", "prettier.config.json" },
          url = "https://json.schemastore.org/prettierrc.json",
        },
        {
          fileMatch = { ".eslintrc", ".eslintrc.json" },
          url = "https://json.schemastore.org/eslintrc.json",
        },
        {
          fileMatch = { "now.json", "vercel.json" },
          url = "https://json.schemastore.org/now.json",
        },
        {
          fileMatch = { "settings.json" },
          url = "https://www.schemastore.org/claude-code-settings.json",
        },
      },
      format     = { enable = true, singleQuote = false },
      validate   = { enable = true },
      completion = true,
      hover      = true,
    },
  },
}
