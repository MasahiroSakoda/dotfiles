-- -*-mode:lua-*- vim:ft=lua

return {
  {
    "folke/sidekick.nvim",
    cmd    = "Sidekick",
    cond   = not vim.g.vscode,
    config = function() require("ai.sidekick") end,
  },
}
