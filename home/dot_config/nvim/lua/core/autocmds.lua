local g, bo, fn, api, keymap =  vim.g, vim.bo, vim.fn, vim.api, vim.keymap.set
local autocmd = api.nvim_create_autocmd
local augroup = function(name)
  return api.nvim_create_augroup("dotfiles_" .. name, { clear = true })
end

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

autocmd("BufWritePre", {
  desc    = "Strip trailing new lines at the end of file on save",
  group   = augroup "TrailStripper",
  pattern = "*",
  command = ":%s/\\n\\+\\%$//e",
})

autocmd({ "BufWinEnter" }, {
  desc     = "Open :help with vertical split",
  pattern  = { "*.txt", "*.jax" },
  callback = function()
    if vim.bo.filetype == "help" then vim.cmd.wincmd("L") end
  end
})

autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
  desc    = "Check if we need to reload the file when it changed",
  group   = augroup("checktime"),
  command = "checktime",
})

autocmd({ "VimEnter", "FileType", "BufEnter", "WinEnter" }, {
  desc     = "URL Highlighting",
  group    = augroup "highlight_url",
  callback = function(_) highlight_url() end,
})

autocmd("TextYankPost", {
  desc     = "Highlight on yank",
  group    = augroup "highlight_yank",
  pattern  = "*",
  callback = function(_) vim.highlight.on_yank() end,
})

autocmd("FileType", {
  desc    = "Close specific filetype with <q>",
  group   = augroup "close_with_q",
  pattern = { "help", "man", "qf", "lspinfo", "notify", "toggleterm", "oil" },
  callback = function (event)
    bo[event.buf].buflisted = false
    keymap("n", "q", "<CMD>close<CR>", { buffer = event.buf, silent = true })
  end,
})

autocmd({ "BufRead", "BufNewFile" }, {
  desc     = "Surveillance chezmoi target files",
  pattern  = { os.getenv("HOME") .. "/.local/share/chezmoi/*" },
  callback = function() vim.schedule(require("chezmoi.commands.__edit").watch) end,
})

local wr_group = vim.api.nvim_create_augroup('WinResize', { clear = true })
autocmd({ "VimResized" }, {
  group   = wr_group,
  pattern = "*",
  command = "wincmd =",
  desc    = "Automatically resize windows when the host window size changes.",
})

autocmd({ "QuickFixCmdPre" }, {
  desc  = "Override Quickfix to trouble.nvim qflist",
  callback = function()
    vim.schedule(function() vim.cmd([[Trouble qflist open focus=true]]) end)
  end,
})

local task_group = vim.api.nvim_create_augroup("UserMakePrg", { clear = true })
autocmd({ "BufEnter" }, {
  desc  = "Detect Taskfile",
  group = task_group,
  pattern = { "*" },
  callback = function(_)
    local scan  = require("plenary.scandir")
    local files = scan.scan_dir(".", { hidden = false, depth = 1, search_pattern = "Taskfile.*" })
    if #files > 0 then vim.o.makeprg = "task" end
  end,
})

local lsp_group = vim.api.nvim_create_augroup("UserLspConfig", {})
autocmd({ "LspAttach" }, {
  desc  = "LSP Actions",
  group = lsp_group,
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

    -- Configure LSP related keymap
    local bufopts = { noremap = true, silent = true, buffer = ev.buf }
    local extend = vim.tbl_extend
    vim.keymap.set("n", "K",  vim.lsp.buf.hover,          extend("force", bufopts, { desc = "Hover Docs" }))
    vim.keymap.set("n", "gd", vim.lsp.buf.definition,     extend("force", bufopts, { desc = "Definition" }))
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration,    extend("force", bufopts, { desc = "Declaration" }))
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, extend("force", bufopts, { desc = "Implementation" }))
    vim.keymap.set("n", "gr", vim.lsp.buf.references,     extend("force", bufopts, { desc = "References" }))
    vim.keymap.set("n", "ga", vim.lsp.buf.code_action,    extend("force", bufopts, { desc = "Code Action" }))

    -- Format on save
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if client ~= nil and client.supports_method("textDocument/formatting") then
      vim.api.nvim_create_autocmd({ "BufWritePre" }, {
        desc  = "Format on save via LSP",
        group = lsp_group,
        callback = function() require("lsp.config.format") end
      })
      -- vim.api.nvim_create_user_command("LspFormat", function() require("lsp.config.format") end, {})
    end
  end
})

api.nvim_create_augroup("OilRelativePathFix", {})
autocmd({ "BufLeave" }, {
  group    = "OilRelativePathFix",
  pattern  = "oil:///*",
  callback = function() vim.cmd("cd .") end,
})
