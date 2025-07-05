local g, bo, fn, keymap =  vim.g, vim.bo, vim.fn, vim.keymap.set
local augroup = function(name) return vim.api.nvim_create_augroup(name, { clear = true }) end

local url_pattern  = "(h?ttps?|ftp|file|ssh|git)://[%w-_%.%?%.:/%+=&]+"
local lowlight_url = function()
  for _, match in ipairs(fn.getmatches()) do
    if match.group == "HighlightURL" then fn.matchdelete(match.id) end
  end
end

local highlight_url = function()
  lowlight_url()
  if g.highlighturl_enabled then fn.matchadd("HighlightURL", url_pattern, 15) end
end

vim.api.nvim_create_autocmd("BufWritePre", {
  desc    = "Strip trailing new lines at the end of file on save",
  group   = augroup("TrailStripper"),
  pattern = "*",
  command = ":%s/\\n\\+\\%$//e",
})

vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
  desc     = "help config (vertical split & no number)",
  pattern  = { "*.txt", "*.jax" },
  callback = function()
    if vim.bo.filetype == "help" then
      vim.cmd.wincmd("L")
      vim.opt_local.number = false
    end
  end
})

vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
  desc    = "Check if we need to reload the file when it changed",
  group   = augroup("checktime"),
  command = "checktime",
})

vim.api.nvim_create_autocmd({ "VimEnter", "FileType", "BufEnter", "WinEnter" }, {
  desc     = "URL Highlighting",
  group    = augroup "highlight_url",
  callback = function(_) highlight_url() end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
  desc     = "Highlight on yank",
  group    = augroup("highlight_yank"),
  pattern  = "*",
  callback = function(_) vim.hl.on_yank() end,
})

vim.api.nvim_create_autocmd("FileType", {
  desc     = "Close specific filetype with <q>",
  group    = augroup("close_with_q"),
  pattern  = { "help", "man", "qf", "lspinfo", "notify", "oil" },
  callback = function (event)
    bo[event.buf].buflisted = false
    keymap("n", "q", "<CMD>close<CR>", { buffer = event.buf, silent = true })
  end,
})

local cursor_grp = augroup("CustomCursor")
vim.api.nvim_create_autocmd({ "BufEnter", "FocusGained", "InsertLeave", "CmdlineLeave", "WinEnter" }, {
  desc    = "enable cursorcolumn automatically",
  pattern = "*",
  group   = cursor_grp,
  callback = function()
    if vim.o.nu and vim.api.nvim_get_mode().mode ~= "i" and vim.bo.filetype ~= "codecompanion" then
      vim.opt.cursorcolumn = true
    end
  end,
})

vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost", "InsertEnter", "CmdlineEnter", "WinLeave" }, {
  desc    = "disable cursorcolumn automatically",
  pattern = "*",
  group   = cursor_grp,
  callback = function()
    if vim.o.nu then
      vim.opt.cursorcolumn = false
      vim.cmd("redraw")
    end
  end,
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  desc     = "Surveillance chezmoi target files",
  pattern  = { os.getenv("HOME") .. "/.local/share/chezmoi/*" },
  callback = function() vim.schedule(require("chezmoi.commands.__edit").watch) end,
})

vim.api.nvim_create_autocmd({ "VimResized" }, {
  desc    = "Automatically resize windows when the host window size changes.",
  group   = augroup("WinResize"),
  pattern = "*",
  command = "wincmd =",
})

vim.api.nvim_create_autocmd({ "QuickFixCmdPost" }, {
  desc     = "Override Quickfix to trouble.nvim qflist",
  callback = function()
    vim.cmd([[cclose | Trouble qflist open focus=true]])
  end,
})

vim.api.nvim_create_autocmd({ "LspAttach" }, {
  desc     = "LSP Actions (keymaps, auto format)",
  group    = augroup("UserLspConfig"),
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

    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    -- Enable completion
    if client ~= nil and client:supports_method("textDocument/completion", ev.buf) then
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

    -- Format on save
    if client ~= nil and client:supports_method("textDocument/formatting", ev.buf) then
      vim.api.nvim_create_autocmd({ "BufWritePre" }, {
        desc     = "Format on save via LSP",
        group    = augroup("UserLspConfig"),
        callback = require("lsp.config.format"),
      })
    end
  end
})

vim.api.nvim_create_autocmd({ "BufLeave" }, {
  group    = augroup("OilRelativePathFix"),
  pattern  = "oil:///*",
  callback = function() vim.cmd("cd .") end,
})
