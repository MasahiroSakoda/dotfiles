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
  debug = false,
  -- builtin sources: https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md
  diagnostics_format = "#{m} (#{s}: #{c})",
  sources = {
    -- Common Configurations
    formatting.trim_newlines,
    formatting.trim_whitespace,
    diagnostics.todo_comments,
    -- formatting.codespell.with({
    --   disabled_filetypes = { "css", "bib" },
    -- }),
    diagnostics.codespell.with({
      extra_args = { "--ignore-words", vim.fn.stdpath "config" .. "/spell/codespell-ignore.txt" },
      filetypes = { "markdown", "latex", "rst", "txt" },
      disabled_filetypes = { "css", "bib", "log" },
    }),
    hover.dictionary,
    hover.printenv,
    completion.spell,
    completion.tags,

    -- Dockerfile
    diagnostics.hadolint.with({
      filetypes = { "dockerfile" },
    }),

    -- Git
    code_actions.gitsigns,

    -- GitHub Actions workflow
    diagnostics.actionlint.with({
      filetypes = filetypes.actions,
      condition = function(_)
        local path = api.nvim_buf_get_name(api.nvim_get_current_buf())
        return path:match("github/workflows/") ~= nil
      end,
    }),

    -- Linter for make
    diagnostics.checkmake.with({
      filetypes  = filetypes.makefile,
       extra_args = { "--config", vim.fn.stdpath "config" .. "/format/checkmake.toml" },
    }),
    -- CMake
    formatting.cmake_format.with({
      filetypes = { "cmake" },
    }),
    diagnostics.cmake_lint,

    -- C/C++
    -- diagnostics.clang_check,
    -- diagnostics.cpplint,
    formatting.clang_format.with({
      condition  = function(utils)
        return utils.root_has_file(filetypes.lsp.clang_format)
      end,
      filetypes  = { "c", "h", "cpp", "hpp", "cxx", "cc", "hxx", "tcc" },
      extra_args = {
        "--style={"
        .. "BasedOnStyle: llvm, "
        .. "IndentWidth: 4, "
        .. "PointerAlignment: Left, "
        .. "ReferenceAlignment: Left, "
        .. "IndentCaseLabels: true}"
      },
    }),

    -- Go
    diagnostics.revive.with({
      condition = function(utils)
        return utils.has_file(filetypes.lsp.revive)
      end
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
      condition    = function(utils)
        return utils.has_file(filetypes.lsp.ruff)
      end,
    },

    -- Lua
    -- stylua:
    formatting.stylua.with({
      filetypes  = filetypes.lsp.stylua,
      extra_args = { "--config", vim.fn.stdpath "config" .. "/format/stylua.toml" },
    }),

    -- biome: JavaScript, TypeScript
    formatting.biome.with({
      -- INFO: support language might be updated
      -- check https://biomejs.dev/internals/language-support/
      filetypes = { "javascript", "typescript", "javascriptreact", "typescriptreact", "json", "jsonc" },
      condition = function(utils)
        -- TODO: uncomment after following command is usable
        --`biome migrate prettier` & `biome migrate eslint`
        -- if utils.has_file(filetypes.lsp.prettier) then
        --   vim.fn.system({ "biome", "migrate", "prettier" })
        --   vim.notify("`prettier` config migrated to `biome.json`", vim.log.levels.INFO)
        -- elseif utils.has_file(filetypes.lsp.eslint) then
        --   vim.fn.system({ "biome", "migrate", "eslint" })
        --   vim.notify("`eslint` config migrated to `biome.json`", vim.log.levels.INFO)
        -- end
        return utils.has_file(filetypes.lsp.biome)
      end,
      args = {
        "check",
        "--apply-unsafe",
        "--formatter-enabled=true",
        "--organize-imports-enabled=true",
        "--skip-errors",
        "$FILENAME",
      },
    }),

    diagnostics.deno_lint.with({
      filetypes = { "javascript", "typescript", "javascriptreact", "typescriptreact", "json", "jsonc" },
      condition = function(utils) return utils.has_file(filetypes.lsp.deno) end,
    }),
    formatting.deno_fmt.with({
      filetypes = { "javascript", "typescript", "javascriptreact", "typescriptreact", "json", "jsonc" },
      condition = function(utils) return utils.has_file(filetypes.lsp.deno) end,
    }),

    formatting.markdownlint.with({
      filetypes = filetypes.markdown,
    }),

    -- VimScript
    diagnostics.vint,
  },
  on_attach = on_attach,
})
