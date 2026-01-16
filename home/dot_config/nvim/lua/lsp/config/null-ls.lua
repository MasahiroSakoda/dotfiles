-- -*-mode:lua-*- vim:ft=lua

local ok, nl = pcall(require, "null-ls")
if not ok then return end

local builtins     = nl.builtins
local formatting   = builtins.formatting
local diagnostics  = builtins.diagnostics
local code_actions = builtins.code_actions
local hover        = builtins.hover
local completion   = builtins.completion

local augroup   = vim.api.nvim_create_augroup("LspFormatting", { clear = false })
local filetypes = require("user.filetypes")

local on_attach = function(client, bufnr)
  if client:supports_method(vim.lsp.protocol.Methods.textDocument_formatting, bufnr) then
    vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
    vim.api.nvim_create_autocmd("BufWritePre", {
      group    = augroup,
      buffer   = bufnr,
      callback = function()
        -- Only use null-ls for formatting to avoid conflicts with other LSPs
        vim.lsp.buf.format({ async  = false, filter = function(c) return c.name == "null-ls" end })
      end,
    })
  end
end

nl.setup({
  debug = false,
  -- ref: https://github.com/nvimtools/none-ls.nvim/blob/main/doc/BUILTINS.md
  sources = {
    -- Common Configurations
    diagnostics.trail_space,
    diagnostics.todo_comments,
    hover.dictionary.with({
      filetypes = { "tex", "text", "markdown", "vimwiki" },
    }),
    hover.printenv.with({
      filetypes = { "sh", "bash", "zsh", "dosbatch", "ps1" },
    }),
    completion.spell.with({
      filetypes = { "text", "markdown" },
    }),
    completion.tags,

    -- Dockerfile
    diagnostics.hadolint.with({ filetypes = { "dockerfile" } }),

    -- Git
    code_actions.gitsigns,

    -- GitHub Actions workflow
    diagnostics.actionlint.with({
      filetypes = filetypes.actions,
      condition = function(_)
        local path = vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf())
        return path:match("github/workflows/") ~= nil
      end,
    }),

    -- Linter for make
    diagnostics.checkmake.with({
      filetypes  = filetypes.makefile,
      extra_args = { "--config", vim.fn.stdpath "config" .. "/format/checkmake.toml" },
    }),

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
    diagnostics.golangci_lint.with({
      filetypes  = filetypes.lang.go,
      extra_args = { "--fast" },
      condition  = function(utils) return utils.root_has_file(filetypes.lsp.golangci) end,
    }),

    -- Shell
    formatting.shfmt.with({
      -- zsh is not supported but enable anyway
      extract_filetypes = filetypes.lang.shell,
      extra_args = { "--indent", "2", "--case-indent", "--space-redirects" },
    }),

    -- fish
    diagnostics.fish,

    -- Ruby
    diagnostics.rubocop.with({
      condition = function(utils) return utils.root_has_file(filetypes.lsp.ruby) end,
    }),
    formatting.rubocop.with({
      condition = function(utils) return utils.root_has_file(filetypes.lsp.ruby) end,
    }),

    -- markdown
    diagnostics.markdownlint.with({
      filetypes  = filetypes.markdown,
      extra_args = { "--config", vim.fn.expand("~/.local/share/chezmoi/.markdownlint.yml") },
    }),
    formatting.markdownlint.with({
      filetypes  = filetypes.markdown,
      extra_args = { "--config", vim.fn.expand("~/.local/share/chezmoi/.markdownlint.yml") },
    }),

    -- YAML
    formatting.yamlfmt.with({
      filetypes  = filetypes.yaml,
      extra_args = { "-formatter", "retain_line_breaks_single=true" },
    }),

    --SQL
    diagnostics.sqruff.with({
      filetypes = { "sql", "mysql" },
      condition = function(utils) return utils.root_has_file(filetypes.lsp.sqruff) end,
    }),
    formatting.sqruff.with({
      filetypes = { "sql", "mysql" },
      condition = function(utils) return utils.root_has_file(filetypes.lsp.sqruff) end,
    }),
  },
  on_attach = on_attach,
})
