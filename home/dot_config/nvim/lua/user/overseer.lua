-- -*-mode:lua-*- vim:ft=lua

local ok, overseer = pcall(require, "overseer")
if not ok then return end

overseer.setup({
  -- DO NOT add chezmoi attributed prefix (e.g. "run_*")
  -- See also: https://www.chezmoi.io/reference/source-state-attributes/
  templates = { "builtin", "user.build_go", "user.test_go", "user.python" },
  task_list = {
    direction  = "bottom", ---@type "left"|"right"|"bottom"
    min_height = 10,
    max_height = 15,
    default_detail = 1, ---@type 1|2|3
  },
  dap = false,
  strategy = {
    "toggleterm",
    use_shell = false,
    direction     = nil,      ---@type nil|"vertical"|"horizontal"|"tab"|"float"
    close_on_exit = true,
    quit_on_exit  = "always", ---@type "always"|"success"|"never"
    open_on_start = true,
    auto_scroll   = true,
  },
})
