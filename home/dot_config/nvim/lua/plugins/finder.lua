-- -*-mode:lua-*- vim:ft=lua

return {
  {
    "ibhagwan/fzf-lua",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    cond   = not vim.g.vscode,
    cmd    = "FzfLua",
    config = function() require("finder") end,
  },
}
