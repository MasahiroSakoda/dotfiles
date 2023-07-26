local ok, nl = pcall(require, "null-ls")
if not ok then return end

local api, lsp = vim.api, vim.lsp
local buf = lsp.buf
local builtins     = nl.builtins
local formatting   = builtins.formatting
local diagnostics  = builtins.diagnostics
local code_actions = builtins.code_actions
local hover        = builtins.hover
local completion   = builtins.completion
local augroup = api.nvim_create_augroup("LspFormatting", {})

local filetypes = require("user.filetypes")

local lsp_formatting = function(bufnr)
  buf.format({
    filter = function(client)
      -- Only use null-ls for formatting to avoid conflicts with other LSPs
      return client.name == "null-ls"
    end,
    bufnr = bufnr
  })
end

local on_attach = function(client, bufnr)
  if client.supports_method("textDocument/formatting") then
    api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
    api.nvim_create_autocmd("BufWritePre", {
      group = augroup,
      buffer = bufnr,
      callback = function()
        lsp_formatting(bufnr)
      end,
    })
  end
end

nl.setup({
  debug = true,
  -- builtin sources: https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md
  diagnostics_format = "#{m} (#{s}: #{c})",
  sources = {
    -- Common Configurations
    formatting.trim_newlines,
    formatting.trim_whitespace,
    diagnostics.todo_comments,
    diagnostics.codespell.with({
      extra_args = { "--ignore-words", vim.fn.stdpath "config" .. "/spell/codespell-ignore.txt" },
      disabled_filetypes = {},
    }),
    hover.dictionary,
    hover.printenv,
    completion.spell,
    completion.tags,

    -- Dockerfile
    builtins.diagnostics.hadolint,

    -- Git
    code_actions.gitsigns,

    -- Linter for make
    diagnostics.checkmake.with({
      filetypes  = filetypes.makefile,
       extra_args = { "--config", vim.fn.stdpath "config" .. "/format/checkmake.toml" },
    }),
    -- CMake
    formatting.cmake_format,
    diagnostics.cmake_lint,

    -- C/C++
    -- diagnostics.clang_check,
    -- diagnostics.cpplint,
    formatting.clang_format.with({
      condition  = function(utils)
        return utils.root_has_file(filetypes.lsp.clang_format)
      end,
      filetype   = { "c", "h", "cpp", "hpp", "cxx", "cc", "hxx", "tcc" },
      extra_args = {
        "--style={"
        .. "BasedOnStyle: llvm, "
        .. "IndentWidth: 4, "
        .. "PointerAlignment: Left, "
        .. "ReferenceAlignment: Left, "
        .. "IndentCaseLabels: true}"
      },
    }),

    -- beautysh: bash/csh/ksh/sh/zsh formatter
    formatting.beautysh.with({
      extra_args = { "--indent-size", "2" },
    }),
    -- fish
    diagnostics.fish,

    -- Python
    diagnostics.ruff.with {
      prefer_local = "venv/bin",
      extra_args   = { "--line-length", "120" },
    },
    formatting.black.with {
      extra_args   = { "--line-length", "120", "--fast", "--extend-select" },
    },

    -- Ruby
    -- rubocop: Static Code Analyzer for Ruby
    -- diagnostics.rubocop.with({
    --   prefer_local = "vendor/bin",
    --   command      = "bin/rubocop",
    --   condition    = function(utils) return utils.root_has_file(filetypes.lsp.rubocop) end,
    -- }),
    -- formatting.rubocop.with({
    --   prefer_local = "vendor/bin",
    --   command      = "bin/rubocop",
    --   condition    = function(utils) return utils.root_has_file(filetypes.lsp.rubocop) end,
    -- }),

    -- Lua
    -- stylua:
    formatting.stylua.with({
      filetypes  = filetypes.lsp.stylua,
      extra_args = { "--config", vim.fn.stdpath "config" .. "/format/stylua.toml" },
    }),

    -- prettier: JS, TS, JSON, YAML, md, GraphQL, etc...
    formatting.prettier.with({
      command   = "node_modules/.bin/prettier",
      filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "css", "scss", "less", "graphql" },
      condition = function(utils)
        return utils.has_file(filetypes.lsp.prettier) and not utils.has_file(filetypes.lsp.eslint)
      end,
    }),
    diagnostics.eslint.with({
      prefer_local = "node_modules/.bin",
      -- command      = "bin/eslint",
      condition    = function(utils)
        return utils.has_file(filetypes.lsp.eslint) and not utils.has_file(filetypes.lsp.prettier)
      end,
    }),
    code_actions.eslint,
    -- formatting.deno_fmt,

    formatting.markdownlint.with({
      filetypes = filetypes.markdown,
    }),

    -- VimScript
    diagnostics.vint,
  },
  on_attach = on_attach,
})
