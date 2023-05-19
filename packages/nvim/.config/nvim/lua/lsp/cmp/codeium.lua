local ok, codeium = pcall(require, "codeium")
if not ok then return end

vim.g.codeium_filetypes = {
  TelescopePrompt = false,
  bash     = false,
  markdown = false,
  text     = false,
}

codeium.setup({})
