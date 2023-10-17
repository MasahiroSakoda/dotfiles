local g, o, bo, fn, api, keymap =  vim.g, vim.o, vim.bo, vim.fn, vim.api, vim.keymap.set
local autocmd = api.nvim_create_autocmd
local augroup = function(name)
  return api.nvim_create_augroup("dotfiles_" .. name, { clear = true })
end

local url_pattern =
  "\\v\\c%(%(h?ttps?|ftp|file|ssh|git)://|[a-z]+[@][a-z]+[.][a-z]+:)%([&:#*@~%_\\-=?!+;/0-9a-z]+%(%([.;/?]|[.][.]+)[&:#*@~%_\\-=?!+/0-9a-z]+|:\\d+|,%(%(%(h?ttps?|ftp|file|ssh|git)://|[a-z]+[@][a-z]+[.][a-z]+:)@![0-9a-z]+))*|\\([&:#*@~%_\\-=?!+;/.0-9a-z]*\\)|\\[[&:#*@~%_\\-=?!+;/.0-9a-z]*\\]|\\{%([&:#*@~%_\\-=?!+;/.0-9a-z]*|\\{[&:#*@~%_\\-=?!+;/.0-9a-z]*})\\})+"

local lowlight_url = function()
  for _, match in ipairs(fn.getmatches()) do
    if match.group == "HighlightURL" then fn.matchdelete(match.id) end
  end
end

local highlight_url = function()
  lowlight_url()
  if g.highlighturl_enabled then fn.matchadd("HighlightURL", url_pattern, 15) end
end

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

autocmd("BufWritePre", {
  desc    = "Strip trailing whitespace from all files",
  group   = augroup "trailing_whitespace",
  pattern = "*",
  command = "%s/s+$//e",
})

-- Auto `chezmoi apply`
-- autocmd("BufWritePost", {
--   group   = augroup "chezmoi_apply",
--   pattern = fn.expand("~") .. "/.local/share/chezmoi/*",
--   command = "silent! !chezmoi apply --force",
-- })

autocmd("TextYankPost", {
  desc     = "Highlight on yank",
  group    = augroup "highlight_yank",
  pattern  = "*",
  callback = function(_) vim.highlight.on_yank() end,
})

autocmd("FileType", {
  desc    = "Close specific filetype with <q>",
  group   = augroup "close_with_q",
  pattern = {
    "checkhealth",
    "git",
    "help",
    "man",
    "qf",
    "startuptime",
    "lspinfo",
    "notify",
    "neotest-output",
    "neotest-output-panel",
    "neotest-summary",
    "toggleterm",
  },
  callback = function (event)
    bo[event.buf].buflisted = false
    keymap("n", "q", "<CMD>close<CR>", { buffer = event.buf, silent = true })
  end,
})
