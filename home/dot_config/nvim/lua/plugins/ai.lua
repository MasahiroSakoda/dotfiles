-- -*-mode:lua-*- vim:ft=lua

return {
  -- ChatGPT client
  {
    "jackMort/ChatGPT.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-telescope/telescope.nvim",
    },
    cond   = vim.g.chatgpt_enabled,
    cmd    = { "ChatGPT", "ChatGPTRun", "ChatGPTActAs", "ChatGPTCompleteCode", "ChatGPTEditWithInstructions" },
    config = function() require("ai.chatgpt") end,
  }
}
