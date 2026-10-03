-- -*-mode:lua-*- vim:ft=lua

return {
  -- LSP
  -- TODO: Enable Copilot language server once its memory consumption issue is resolved.
  -- copilot       = require("config.lsp.servers.copilot"),       -- GitHub Copilot
  clangd        = require("config.lsp.servers.clangd"),        -- C/C++, ObjC, Swift, Rust
  gopls         = require("config.lsp.servers.gopls"),         -- Go
  rust_analyzer = require("config.lsp.servers.rust_analyzer"), -- Rust
  bashls        = require("config.lsp.servers.bashls"),        -- bash
  fish_lsp      = require("config.lsp.servers.fish_lsp"),      -- Fish
  ty            = require("config.lsp.servers.ty"),            -- Python
  ruby_lsp      = require("config.lsp.servers.ruby_ls"),       -- Ruby
  lua_ls        = require("config.lsp.servers.lua_ls"),        -- Lua
  vtsls         = require("config.lsp.servers.vtsls"),         -- TypeScript
  denols        = require("config.lsp.servers.denols"),        -- Deno
  -- oxlint        = require("config.lsp.servers.oxlint"),        -- JavaScript / TypeScript
  -- oxfmt         = require("config.lsp.servers.oxfmt"),         -- JavaScript / TypeScript
  cssls         = require("config.lsp.servers.cssls"),         -- CSS
  tailwindcss   = require("config.lsp.servers.tailwindcss"),   -- tailwindcss
  jsonls        = require("config.lsp.servers.jsonls"),        -- JSON
  yamlls        = require("config.lsp.servers.yamlls"),        -- YAML
  tombi         = require("config.lsp.servers.tombi"),         -- TOML
  rumdl         = require("config.lsp.servers.rumdl"),         -- Markdown
  dockerls      = require("config.lsp.servers.dockerls"),      -- Docker
  terraformls   = require("config.lsp.servers.terraformls"),   -- Terraform
  zizmor        = require("config.lsp.servers.zizmor"),        -- GitHub Actions
  sqls          = require("config.lsp.servers.sqls"),          -- SQL
  texlab        = require("config.lsp.servers.texlab"),        -- LaTex
  -- harper        = require("config.lsp.servers.harper_ls"),     -- english grammar
}
