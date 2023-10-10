local ok, trouble = pcall(require, "trouble")
if not ok then return end

trouble.setup({
  auto_open     = false,
  auto_close    = false,
  auto_preview  = true,
  auto_fold     = false,
  indent_lines  = true,

  height = 10,
  width  = 50,
  icons  = true,
  mode   = "workspace_diagnostics",

  fold_open   = "",
  fold_closed = "",
  group       = true,
  padding     = false,

  signs = {
    error       = "",
    warning     = "",
    hint        = "",
    information = "",
    other       = ""
  },

  action_keys   = {
    close       = "q",
    cancel      = { "<esc>", "<C-c>" },
    previous    = "k",
    next        = "j",
    refresh     = "r",
    jump        = {"<cr>", "<tab>"},
    jump_close  = "o",
    hover       = "zh",
    preview     = "p",
    toggle_preview = "P",

    toggle_mode = "m",
    open_split  = "<C-x>",
    open_vsplit = "<C-v>",
    open_tab    = "<C-t>",
    open_folds  = { "zR", "zr" },
    close_folds = { "zM", "zm" },
    toggle_fold = { "zA", "za" },
  },
})

vim.cmd[[ sign define DiagnosticSignError text= texthl=DiagnosticSignError linehl= numhl= ]]
vim.cmd[[ sign define DiagnosticSignWarn  text= texthl=DiagnosticSignWarn  linehl= numhl= ]]
vim.cmd[[ sign define DiagnosticSignInfo  text= texthl=DiagnosticSignInfo  linehl= numhl= ]]
vim.cmd[[ sign define DiagnosticSignHint  text= texthl=DiagnosticSignHint  linehl= numhl= ]]
vim.cmd[[ sign define DiagnosticSignOther text= texthl=DiagnosticSignOther linehl= numhl= ]]
