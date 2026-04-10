local ok, lint = pcall(require, "lint")
if not ok then return end

lint.linters_by_ft = {
  bash = { "bash" },
  zsh  = { "zsh" },
  fish = { "fish" },
  make = { "checkmake" },
  c    = { "clangd" },
  go   = { "golangci-lint" },

  ghaction   = { "actionlint" },
  dockerfile = { "hadolint" },
  markdown   = { "rumdl" },
}
