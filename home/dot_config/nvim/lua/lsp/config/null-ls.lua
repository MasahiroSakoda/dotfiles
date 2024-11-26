-- -*-mode:lua-*- vim:ft=lua

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
        return utils.root_has_file(filetypes.lsp.revive)
      end
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

    -- Lua
    -- stylua:
    formatting.stylua.with({
      filetypes  = { "lua" },
      extra_args = { "--config", vim.fn.stdpath "config" .. "/format/stylua.toml" },
      condition  = function(utils) return utils.root_has_file(filetypes.lsp.stylua) end,
    }),

    diagnostics.markdownlint.with({
      extra_args = {},
      condition = function(utils) return utils.root_has_file(filetypes.lsp.markdownlint) end
    }),
    formatting.markdownlint.with({
      filetypes = filetypes.markdown,
      condition = function(utils) return utils.root_has_file(filetypes.lsp.markdownlint) end
    }),

    -- VimScript
    diagnostics.vint.with({
      args = { "'--enable-neovim", "-s", "-j", "$FILENAME" },
      condition = function() return vim.fn.executable("vint") > 0 end,
    }),
  },
  on_attach = on_attach,
})
