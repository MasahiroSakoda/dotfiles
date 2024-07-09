-- -*-mode:lua-*- vim:ft=lua

return {
  -- LSP
  clangd        = require("lsp.servers.clangd"),        -- C/C++, ObjC, Swift, Rust
  gopls         = require("lsp.servers.gopls"),         -- Go
  rust_analyzer = require("lsp.servers.rust_analyzer"), -- Rust
  bashls        = require("lsp.servers.bashls"),        -- bash
  pyright       = require("lsp.servers.pyright"),       -- Python
  ruby_ls       = require("lsp.servers.ruby_ls"),       -- Ruby
  lua_ls        = require("lsp.servers.lua_ls"),        -- Lua
  tsserver      = require("lsp.servers.tsserver"),      -- JS/TS
  denols        = require("lsp.servers.denols"),        -- Deno
  html          = require("lsp.servers.html"),          -- HTML
  cssls         = require("lsp.servers.cssls"),         -- CSS, SCSS, LESS
  jsonls        = require("lsp.servers.jsonls"),        -- JSON
  yamlls        = require("lsp.servers.yamlls"),        -- YAML
  marksman      = require("lsp.servers.marksman"),      -- Markdown
  cmake         = require("lsp.servers.cmake"),         -- CMake
  dockerls      = require("lsp.servers.dockerls"),      -- Docker
  terraformls   = require("lsp.servers.terraformls"),   -- Terraform
  sqlls         = require("lsp.servers.sqlls"),         -- SQL
  vimls         = require("lsp.servers.vimls"),         -- VimScript
  typos_lsp     = require("lsp.servers.typos"),         -- Spell checker

  -- Linter
  actionlint   = {}, -- GitHub Actions workflow
  revive       = {}, -- Go
  ruff_lsp     = require("lsp.servers.ruff_lsp"), -- Python
  biome        = {}, -- JS/TS & JSON
  rubocop      = {}, -- Ruby Static Code Analyzer
  markdownlint = {}, -- Markdown
  hadolint     = {}, -- Dockerfile
  vint         = {}, -- VimScript

  -- Formetter
  clang_format  = {}, -- C/C++, ObjC, Java, JS, C#, etc..
  shfmt         = {}, -- Sh, Bash
  jq            = {}, -- JSON
  yq            = {}, -- YAML
  yamlformatter = {}, -- YAML
  sql_formatter = {}, -- SQL
}
