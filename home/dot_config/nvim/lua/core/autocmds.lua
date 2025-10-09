local augroup = function(name) return vim.api.nvim_create_augroup(name, { clear = true }) end

-- Dynamic colorcolumn references `max_line_width` from .editorconfig
vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
  callback = function(ev)
    local columns = {}
    table.insert(columns, tostring(vim.bo[ev.buf].textwidth))
    vim.opt_local.colorcolumn = columns
  end,
})

local url_pattern  = "(h?ttps?|ftp|file|ssh|git)://[%w-_%.%?%.:/%+=&]+"
local lowlight_url = function()
  for _, match in ipairs(vim.fn.getmatches()) do
    if match.group == "HighlightURL" then vim.fn.matchdelete(match.id) end
  end
end

local highlight_url = function()
  lowlight_url()
  if vim.g.highlighturl_enabled then vim.fn.matchadd("HighlightURL", url_pattern, 15) end
end

-- Strip trailing new lines at the end of file on save
vim.api.nvim_create_autocmd("BufWritePre", {
  group   = augroup("TrailStripper"),
  command = ":%s/\\n\\+\\%$//e",
})

-- Check if we need to reload the file when it changed
vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
  group   = augroup("checktime"),
  command = "checktime",
})

-- Highlight URL
vim.api.nvim_create_autocmd({ "VimEnter", "FileType", "BufEnter", "WinEnter" }, {
  group    = augroup "highlight_url",
  callback = function(_)
    -- highlight_url()
  end,
})

-- Highlight yank range
vim.api.nvim_create_autocmd("TextYankPost", {
  group    = augroup("highlight_yank"),
  callback = function() vim.hl.on_yank() end,
})

-- Close specific filetype with <q>
vim.api.nvim_create_autocmd("FileType", {
  group    = augroup("close_with_q"),
  pattern  = { "help", "man", "qf", "lspinfo", "notify", "oil", "dap-view", "dap-view-term", "dap-view-repl" },
  callback = function (event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<CMD>close<CR>", { buffer = event.buf, silent = true })
  end,
})

local cursor_grp = augroup("CustomCursor")
-- Enable cursorcolumn automatically
vim.api.nvim_create_autocmd({ "BufEnter", "FocusGained", "InsertLeave", "CmdlineLeave", "WinEnter" }, {
  group    = cursor_grp,
  callback = function()
    if vim.o.nu and vim.api.nvim_get_mode().mode ~= "i" and vim.bo.filetype ~= "codecompanion" then
      vim.opt.cursorcolumn = true
    end
  end,
})

-- Disable cursorcolumn automatically
vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost", "InsertEnter", "CmdlineEnter", "WinLeave" }, {
  group    = cursor_grp,
  callback = function()
    if vim.o.nu then
      vim.opt.cursorcolumn = false
      vim.cmd("redraw")
    end
  end,
})

-- Surveillance chezmoi target files
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern  = { os.getenv("HOME") .. "/.local/share/chezmoi/*" },
  callback = function() vim.schedule(require("chezmoi.commands.__edit").watch) end,
})

-- Automatically resize windows when the host window size changes.
vim.api.nvim_create_autocmd({ "VimResized" }, { group = augroup("WinResize"), command = "wincmd =" })

-- Override Quickfix to trouble.nvim qflist
vim.api.nvim_create_autocmd({ "QuickFixCmdPost" }, {
  callback = function()
    vim.cmd([[cclose | Trouble qflist open focus=true]])
  end,
})

local lsp_augroup = augroup("UserLspGroup")

-- LSP Actions (keymaps, completion, format)
vim.api.nvim_create_autocmd({ "LspAttach" }, {
  group    = lsp_augroup,
  callback = function(ev)
    -- Configure LSP related keymap
    local bufopts = { noremap = true, silent = true, buffer = ev.buf }
    local extend = vim.tbl_extend
    vim.keymap.set("n", "K",   vim.lsp.buf.hover,          extend("force", bufopts, { desc = "Hover Docs" }))
    vim.keymap.set("n", "gd",  vim.lsp.buf.definition,     extend("force", bufopts, { desc = "Definition" }))
    vim.keymap.set("n", "gD",  vim.lsp.buf.declaration,    extend("force", bufopts, { desc = "Declaration" }))
    vim.keymap.set("n", "gri", vim.lsp.buf.implementation, extend("force", bufopts, { desc = "Implementation" }))
    vim.keymap.set("n", "grn", vim.lsp.buf.rename,         extend("force", bufopts, { desc = "Rename" }))
    vim.keymap.set("n", "grr", vim.lsp.buf.references,     extend("force", bufopts, { desc = "References" }))
    vim.keymap.set("n", "gra", vim.lsp.buf.code_action,    extend("force", bufopts, { desc = "Code Action" }))

    local client = assert(vim.lsp.get_client_by_id(ev.data.client_id))
    -- Enable completion
    if client:supports_method(vim.lsp.protocol.Methods.textDocument_completion, ev.buf) then
      vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

      local kinds_ok, kinds = pcall(require, "lspkind")
      vim.lsp.completion.enable(true, client.id, ev.buf, {
        autotrigger = true,
        convert = function(item)
          local kind = vim.lsp.protocol.CompletionItemKind[item.kind] or "Unknown"
          local icon = kinds_ok and string.format("%s", kinds.presets.default[kind]) or kind
          return { abbr = icon .. " " .. item.label, kind = kind, menu = item.detail or "", icase = 1 }
        end
      })
    end

    -- Format on save via LSP
    local format_group = vim.api.nvim_create_augroup("LspFormatting", { clear = false })
    if client:supports_method(vim.lsp.protocol.Methods.textDocument_formatting, ev.buf) then
      vim.api.nvim_clear_autocmds({ group = format_group, buffer = ev.buf })
      vim.api.nvim_create_autocmd({ "BufWritePre" }, {
        group    = format_group,
        buffer   = ev.buf,
        callback = require("lsp.config.format"),
      })
    end
  end
})

-- Workaround oil.nvim relative path issue
-- https://github.com/stevearc/oil.nvim/issues/234
vim.api.nvim_create_autocmd({ "BufLeave" }, {
  group    = augroup("OilRelativePathFix"),
  pattern  = "oil:///*",
  callback = function() vim.cmd("cd .") end,
})
