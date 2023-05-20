local api, fn, o = vim.api, vim.fn, vim.o
local autocmd = api.nvim_create_autocmd
local augroup = api.nvim_create_augroup

autocmd("BufWritePre", {
	group = "buffer",
	pattern = "*",
	command = "%s/s+$//e",
	desc = "Strip trailing whitespace from all files",
})

autocmd("BufWritePost", {
	group = "buffer",
	pattern = vim.fn.expand("~") .. "/.local/share/chezmoi/*",
	command = "silent! !chezmoi apply --force",
	desc = "Auto update dotfiles",
})
