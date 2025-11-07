-- -*-mode:lua-*- vim:ft=lua

local group = vim.api.nvim_create_augroup("CustomMarkdownGroup", { clear = true })

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern  = { "*.mdx" },
  group    = group,
  callback = function(ev)
    vim.api.nvim_set_option_value("FileType", { "markdown", "mdx" }, { buf = ev.buf })
    vim.bo.filetype = "markdown"
    -- Use TSX syntax highlighting for MDX since MDX parser isn't available
    vim.treesitter.language.register("tsx", "mdx")
  end,
})
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern  = "mdx",
  group    = group,
  callback = function()
    vim.bo.syntax        = "markdown"
    vim.wo.foldmethod    = "syntax"
    vim.bo.commentstring = "{/* %s */}"
  end,
})
