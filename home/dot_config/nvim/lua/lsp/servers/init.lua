-- -*-mode:lua-*- vim:ft=lua

return {
  -- LSP
  copilot       = require("lsp.servers.copilot"),       -- GitHub Copilot
  clangd        = require("lsp.servers.clangd"),        -- C/C++, ObjC, Swift, Rust
  glsl_analyzer = require("lsp.servers.glsl_analyzer"), -- GLSL
  gopls         = require("lsp.servers.gopls"),         -- Go
  rust_analyzer = require("lsp.servers.rust_analyzer"), -- Rust
  bashls        = require("lsp.servers.bashls"),        -- bash
  pyright       = require("lsp.servers.pyright"),       -- Python
  ruby_lsp      = require("lsp.servers.ruby_ls"),       -- Ruby
  lua_ls        = require("lsp.servers.lua_ls"),        -- Lua
  ts_ls         = require("lsp.servers.ts_ls"),         -- JS/TS
  denols        = require("lsp.servers.denols"),        -- Deno
  tailwindcss   = require("lsp.servers.tailwindcss"),   -- tailwindcss
  jsonls        = require("lsp.servers.jsonls"),        -- JSON
  yamlls        = require("lsp.servers.yamlls"),        -- YAML
  tombi         = require("lsp.servers.tombi"),         -- TOML
  just          = require("lsp.servers.just"),          -- Justfile
  marksman      = require("lsp.servers.marksman"),      -- Markdown
  dockerls      = require("lsp.servers.dockerls"),      -- Docker
  -- terraformls   = require("lsp.servers.terraform"),     -- Terraform
  -- sqlls         = require("lsp.servers.sqlls"),         -- SQL
  texlab        = require("lsp.servers.texlab"),        -- LaTex
  typos_lsp     = require("lsp.servers.typos"),         -- Spell checker

  -- Linter
  ruff          = require("lsp.servers.ruff"), -- Python
  biome         = require("lsp.servers.biome"),    -- JS/TS, JSON & others
  -- rubocop       = require("lsp.servers.rubocop"), -- Ruby Static Code Analyzer
  stylua        = require("lsp.servers.stylua"),  -- Lua
  markdownlint  = {}, -- Markdown
  sqruff        = {}, -- SQL

  -- Formetter
  clang_format  = {}, -- C/C++, ObjC, Java, JS, C#, etc..
}
