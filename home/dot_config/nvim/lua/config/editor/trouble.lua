require("trouble").setup({
  debug        = false,
  focus        = false,
  follow       = false,
  auto_close   = false,
  auto_preview = true,
  auto_refresh = true,
  auto_jump    = true,
  max_items    = 100,

  keys = {
    ["?"]     = "help",
    ["<ESC>"] = "cancel",
    ["<CR>"]  = "jump",
    ["<C-s>"] = "jump_split",
    ["<C-v>"] = "jump_vsplit",
    ["<C-p>"] = "preview",
    ["[["]    = "prev",
    ["]]"]    = "next",
  },
})
