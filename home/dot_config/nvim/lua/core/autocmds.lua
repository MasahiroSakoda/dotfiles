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
  callback = function (ev)
    vim.bo[ev.buf].buflisted = false
    vim.keymap.set("n", "q", "<CMD>close<CR>", { buffer = ev.buf, silent = true })
  end,
})

-- Terminal buffer keymap
vim.api.nvim_create_autocmd({ "FileType" }, {
  group    = vim.api.nvim_create_augroup("TerminalCustomGroup", { clear = true }),
  pattern  = { "terminal", "snacks_terminal", "sidekick_terminal" },
  callback = function(ev)
    -- Defer to ensure overriding default keymaps
    vim.schedule(function()
      require("which-key").add({
        { "<ESC>", "<C-\\><C-n>", mode = { "t" }, icon = "󰈆 ", desc = " Exit Terminal", buffer = ev.buf },
        { "jj",    "<C-\\><C-n>", mode = { "t" }, icon = "󰈆 ", desc = " Exit Terminal", buffer = ev.buf },
      })
    end)
  end,
})

local cursor_grp = augroup("CustomCursor")
-- Enable cursorcolumn automatically
vim.api.nvim_create_autocmd({ "BufEnter", "FocusGained", "InsertLeave", "CmdlineLeave", "WinEnter" }, {
  group    = cursor_grp,
  callback = function()
    if vim.o.nu and vim.api.nvim_get_mode().mode ~= "i" then
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
  pattern  = { vim.env.HOME .. "/.local/share/chezmoi/*" },
  callback = function(ev)
    vim.schedule(function() require("chezmoi.commands.__edit").watch(ev.buf) end)
  end,
})

-- Automatically resize windows when the host window size changes.
vim.api.nvim_create_autocmd({ "VimResized" }, { group = augroup("WinResize"), command = "wincmd =" })

local qf_group = augroup("QuickfixGroup")
-- Open qflist window automatically
vim.api.nvim_create_autocmd({ "QuickFixCmdPost" }, {
  group   = qf_group,
  pattern = { "[^l]*" },
  command = "cwindow",
  nested  = true,
})

-- Open loclist window automatically
vim.api.nvim_create_autocmd({ "QuickFixCmdPost" }, {
  group   = qf_group,
  pattern = { "l*" },
  command = "lwindow",
  nested  = true,
})

local lsp_group = augroup("LspCustomGroup")

-- Keymaps related LSP
vim.api.nvim_create_autocmd({ "LspAttach" }, {
  group    = lsp_group,
  callback = function(ev)
    local extend, opts = vim.tbl_extend, { buffer = ev.buf, noremap = true, silent = true }
    vim.keymap.set("n", "K",          vim.lsp.buf.hover,          extend("keep", opts, { desc = " Hover Docs" }))
    vim.keymap.set("n", "gd",         vim.lsp.buf.definition,     extend("keep", opts, { desc = " Definition" }))
    vim.keymap.set("n", "gD",         vim.lsp.buf.declaration,    extend("keep", opts, { desc = " Declaration" }))
    vim.keymap.set("n", "gri",        vim.lsp.buf.implementation, extend("keep", opts, { desc = " Implementation" }))
    vim.keymap.set("n", "grn",        vim.lsp.buf.rename,         extend("keep", opts, { desc = " Rename" }))
    vim.keymap.set("n", "grf",        vim.lsp.buf.references,     extend("keep", opts, { desc = " References" }))
    vim.keymap.set({"n", "v"}, "gra", vim.lsp.buf.code_action,    extend("keep", opts, { desc = " Code Action" }))
  end
})

-- Enable completion via LSP
vim.api.nvim_create_autocmd({ "LspAttach" }, {
  group    = lsp_group,
  callback = function(ev)
    local client = assert(vim.lsp.get_client_by_id(ev.data.client_id))
    if client:supports_method(vim.lsp.protocol.Methods.textDocument_completion, ev.buf) then
      --Enable completion triggered by <c-x><c-o>
      vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
      vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
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

local snip_grp = augroup("LuaSnipCustomGroup")
local ls = require("luasnip")
-- Disable diagnostics in snippet
vim.api.nvim_create_autocmd({ "ModeChanged" }, {
  group    = snip_grp,
  pattern  = { "n:i", "n:s", "n:v" },
  callback = function(ev)
    if ls.in_snippet() then
      vim.diagnostic.enable(false, { bufnr = ev.buf })
    end
  end,
})

-- Enable diagnostics after leaving snippet
vim.api.nvim_create_autocmd({ "ModeChanged" }, {
  group    = snip_grp,
  pattern  = { "i:n", "s:n", "v:n" },
  callback = function(ev)
    if ls.in_snippet() then
      vim.diagnostic.enable(true, { bufnr = ev.buf })
    end
  end,
})
