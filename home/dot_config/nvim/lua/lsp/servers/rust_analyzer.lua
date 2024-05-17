local ok, lspconfig = pcall(require, "lspconfig")
if not ok then return end

return {
  cmd       = { "rust-analyzer" },
  filetypes = { "rust" },
  root_dir  = lspconfig.util.root_pattern("Cargo.toml", "rust-project.json"),
  settings  = {
    -- Refer to all available options here: https://rust-analyzer.github.io/manual.html
    ["rust-analyzer"] = {
      cargo = { { buildScripts = { enable = true } } },
      imports = { granularity = { group = "module" }, prefix = "self" },
      procMacro = { enable = true },
      completion = {
        autoimport = { enable = true },
        postfix    = { enable = true },
        fullFunctionSignatures = { enable = true },
      },
      assist = {
        importEnforceGranularity = true,
        importPrefix = "crate",
      },
      checkOnSave = {
        allFeatures = true,
        command     = "clippy",
        extraArgs   = { "--no-deps" },
      },
      diagnostics = {
        experimental = { enable = true },
        disabled = { "unresolved-proc-macro" },
      },
      hover = {
        actions = { references = { enable = true } },
      },
      inlayHints = {
        locationLinks = false,
        lifetimeElisionHints = {
          enable = "always", ---@type "always"|"never"
          useParameterNames = true,
        },
      },
    }
  }
}
