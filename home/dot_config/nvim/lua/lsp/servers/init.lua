return {
  -- LSP
  clangd        = require("lsp.servers.clangd"),        -- C, C++, Obj-C Language Server
  gopls         = require("lsp.servers.gopls"),         -- Go Language Server
  rust_analyzer = require("lsp.servers.rust_analyzer"), -- Rust Language Server
  bashls        = require("lsp.servers.bashls"),        -- bash Language Server
  -- sorbet        = require("lsp.servers.sorbet"),        -- Ruby Language Server
  solargraph    = require("lsp.servers.solargraph"),    -- Ruby Language Server
  pyright       = require("lsp.servers.pyright"),       -- Python Language Server
  lua_ls        = require("lsp.servers.lua_ls"),        -- Lua Language Server
  tsserver      = require("lsp.servers.tsserver"),      -- JavaScript/TypeScript Language Server
  denols        = require("lsp.servers.denols"),        -- Deno Language Server
  html          = require("lsp.servers.html"),          -- HTML Language Serer
  cssls         = require("lsp.servers.cssls"),         -- CSS, SCSS, LESS Language Server
  jsonls        = require("lsp.servers.jsonls"),        -- JSON Language Server
  yamlls        = require("lsp.servers.yamlls"),        -- YAML Language Server
  marksman      = require("lsp.servers.marksman"),      -- Markdown Language Server
  cmake         = require("lsp.servers.cmake"),         -- CMake Language Serevr
  dockerls      = require("lsp.servers.dockerls"),      -- Docker Language Server
  terraformls   = require("lsp.servers.terraformls"),   -- Terraform Language Server
  sqlls         = require("lsp.servers.sqlls"),         -- SQL Language Server
  vimls         = require("lsp.servers.vimls"),         -- VimScript Language Server

  -- Linter
  actionlint   = {}, -- GitHub Actions workflow
  cmakelint    = {}, -- CMake
  revive       = {}, -- Go
  hadolint     = {}, -- Dockerfile
  markdownlint = {}, -- Markdown Linter
  vint         = {}, -- VimScript
  biome        = {}, -- JavaScript/TypeScript & JSON
  rubocop      = require("lsp.servers.rubocop"),        -- Ruby Static Code Analyzer
  ruff         = {}, -- Python Linter

  -- Formetter
  clang_format  = {}, -- C, C++, Obj-C, Java, JS, C#, etc..
  beautysh      = {}, -- Sh, Bash, Zsh, Csh, Ksh
  shfmt         = {}, -- Sh, Bash
  black         = {}, -- Python
  jq            = {}, -- JSON
  xmlformatter  = {}, -- XML, XHTML
  yamlformatter = {}, -- YAML
  sql_formatter = {}, -- SQL
}
