-- -*-mode:lua-*- vim:ft=lua

return {
  -- LSP
  -- TODO: Enable Copilot language server once its memory consumption issue is resolved.
  -- copilot       = require("lsp.servers.copilot"),       -- GitHub Copilot
  clangd        = require("lsp.servers.clangd"),        -- C/C++, ObjC, Swift, Rust
  gopls         = require("lsp.servers.gopls"),         -- Go
  rust_analyzer = require("lsp.servers.rust_analyzer"), -- Rust
  bashls        = require("lsp.servers.bashls"),        -- bash
  fish_lsp      = require("lsp.servers.fish_lsp"),      -- Fish
  ty            = require("lsp.servers.ty"),            -- Python
  ruby_lsp      = require("lsp.servers.ruby_ls"),       -- Ruby
  lua_ls        = require("lsp.servers.lua_ls"),        -- Lua
  -- ts_ls         = require("lsp.servers.ts_ls"),         -- JS/TS
  denols        = require("lsp.servers.denols"),        -- Deno
  tailwindcss   = require("lsp.servers.tailwindcss"),   -- tailwindcss
  jsonls        = require("lsp.servers.jsonls"),        -- JSON
  yamlls        = require("lsp.servers.yamlls"),        -- YAML
  tombi         = require("lsp.servers.tombi"),         -- TOML
  marksman      = require("lsp.servers.marksman"),      -- Markdown
  dockerls      = require("lsp.servers.dockerls"),      -- Docker
  terraformls   = require("lsp.servers.terraformls"),   -- Terraform
  zizmor        = require("lsp.servers.zizmor"),        -- GitHub Actions
  sqls          = require("lsp.servers.sqls"),          -- SQL
  texlab        = require("lsp.servers.texlab"),        -- LaTex
  harper        = require("lsp.servers.harper_ls"),     -- english grammer
}
