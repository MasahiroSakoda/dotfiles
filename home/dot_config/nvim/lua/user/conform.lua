local ok, conform = pcall(require, "conform")
if not ok then return end

---@module "conform"
---@type conform.setupOpts
conform.setup({
  default_format_opts = {
    lsp_format = "fallback",
  },

  format_on_save = {
    timeout_ms = 2000,
  },

  formatters_by_ft = {
    ["*"]  = { "trim_whitespace", "trim_newlines" },
    sh     = { "shfmt" },
    make   = { "checkmake" },
    -- lua    = { "stylua" },
    python = { "ruff_fix", "ruff_format", "ruff_organize_imports" },
    ruby   = { "rubocop" },
    c      = { "clang-format" },
    cpp    = { "clang-format" },
    rust   = { "rustfmt" },
    go     = { "golangci-lint" },

    json     = { "jq" },
    jsonc    = { "jq" },
    yaml     = { "yamlfmt", "actionlint" },
    toml     = { "tombi" },
    sql      = { "sqruff" },
    markdown = { "markdownlint-cli2", "typos" },
    tex      = { "typos" },

    css             = { "biome" },
    javascript      = { "biome" },
    javascriptreact = { "biome" },
    typescript      = { "biome" },
    typescriptreact = { "biome" },
    graphql         = { "biome" },
    svelte          = { "biome" },
    vue             = { "biome" },
    astro           = { "biome" },

    dockerfile = { "hadolint" },
  },

  formatters = {
  },
})
