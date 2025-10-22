local augroup = function(name) return vim.api.nvim_create_augroup(name, { clear = true }) end

-- Dynamic colorcolumn references `max_line_width` from .editorconfig
vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
  callback = function(ev)
    local columns = {}
    table.insert(columns, tostring(vim.bo[ev.buf].textwidth))
    vim.opt_local.colorcolumn = columns
  end,
})

-- Strip trailing new lines at the end of file on save
vim.api.nvim_create_autocmd("BufWritePre", { group = augroup("TrailStripper"), command = ":%s/\\n\\+\\%$//e" })

-- Check if we need to reload the file when it changed
vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
  group   = augroup("Checktime"),
  command = "checktime",
})

-- Highlight URL
vim.api.nvim_create_autocmd({ "VimEnter", "FileType", "BufEnter", "WinEnter" }, {
  group    = augroup("HighlightURL"),
  callback = function(_)
    local lines = vim.api.nvim_buf_line_count(vim.api.nvim_get_current_buf())
    local fsize = vim.fn.getfsize(vim.fn.expand "%")
    if lines > 5000 or fsize > 2 * 1024 * 1024 then return end
    require("utils.highlight").set_url_match()
  end,
})

-- Highlight on yanked range
vim.api.nvim_create_autocmd("TextYankPost", {
  group    = augroup("HighlightOnYank"),
  callback = function() vim.hl.on_yank({ higroup = "IncSearch", timeout = 100 }) end,
})

-- Close specific filetype with <q>
vim.api.nvim_create_autocmd("FileType", {
  group    = augroup("CustomClose"),
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
  callback = function() vim.cmd([[cclose | Trouble qflist open focus=true]]) end,
})

local lsp_group = augroup("LspCustomGroup")

-- Keymaps related LSP
vim.api.nvim_create_autocmd({ "LspAttach" }, {
  group    = lsp_group,
  callback = function(ev)
    local extend, opts = vim.tbl_extend, { buffer = ev.buf, noremap = true, silent = true }
    vim.keymap.set("n", "K",          vim.lsp.buf.hover,          extend("keep", opts, { desc = "Hover Docs" }))
    vim.keymap.set("n", "gd",         vim.lsp.buf.definition,     extend("keep", opts, { desc = "Definition" }))
    vim.keymap.set("n", "gD",         vim.lsp.buf.declaration,    extend("keep", opts, { desc = "Declaration" }))
    vim.keymap.set("n", "gri",        vim.lsp.buf.implementation, extend("keep", opts, { desc = "Implementation" }))
    vim.keymap.set("n", "grn",        vim.lsp.buf.rename,         extend("keep", opts, { desc = "Rename" }))
    vim.keymap.set("n", "grf",        vim.lsp.buf.references,     extend("keep", opts, { desc = "References" }))
    vim.keymap.set({"n", "v"}, "gra", vim.lsp.buf.code_action,    extend("keep", opts, { desc = "Code Action" }))
  end
})

-- Enable completion via LSP
vim.api.nvim_create_autocmd({ "LspAttach" }, {
  group    = lsp_group,
  callback = function(ev)
    local client = assert(vim.lsp.get_client_by_id(ev.data.client_id))
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
  end
})

-- Disable completion via LSP
vim.api.nvim_create_autocmd({ "LspDetach" }, {
  callback = function(ev) vim.lsp.completion.enable(false, ev.data.client_id, ev.buf) end
})

-- Format on save automatically via LSP
vim.api.nvim_create_autocmd({ "LspAttach" }, {
  group    = lsp_group,
  callback = function(ev)
    local client = assert(vim.lsp.get_client_by_id(ev.data.client_id))
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
