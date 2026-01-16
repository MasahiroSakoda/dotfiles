-- -*-mode:lua-*- vim:ft=lua

---@type snacks.picker.Config
return {
  focus = "list",
  win = {
    input = {
      ["<Tab>"] = { "select_and_next", mode = { "n", "i" } },
      ["f"]     = { "focus_list",      mode = { "n" } },
      ["2"]     = { "focus_list",      mode = { "n" } },
      ["3"]     = { "focus_preview",   mode = { "n" } },
    },
    list = {
      keys = {
        ["e"]       = { "edit" },
        ["s"]       = { "git_stage" },
        ["<Space>"] = { "git_stage" },
        ["<Tab>"]   = { "select_and_next" },
      },
    },
  },
}
