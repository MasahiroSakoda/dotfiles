local ok, tabnine = pcall(require, "cmp_tabnine.config")
if not ok then return end

tabnine:setup({
  max_lines = 1000,
  max_num_results = 10,
  sort = true,
  run_on_every_keystroke = true,
  snippet_placeholder = '..',

  ignored_file_types = {
    -- default is not to ignore
    -- uncomment to ignore in lua:
    -- lua = true,
    markdown = true,
    text = true,
  },
  show_prediction_strength = false,
})

local api = vim.api
local filetypes = require("user.filetypes")
local prefetch = api.nvim_create_augroup("prefetch", { clear = true })
api.nvim_create_autocmd("BufRead", {
  group = prefetch,
  pattern = filetypes.tabnine,
  callback = function()
    require('cmp_tabnine'):prefetch(vim.fn.expand("%:p"))
  end
})
