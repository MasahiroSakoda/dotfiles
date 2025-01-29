-- -*-mode:lua-*- vim:ft=lua

return {
  strategy = "chat", ---@type "inline"|"chat"
  description = "Correct grammar and reformulate",
  opts = {
    index = 17,
    is_default = true,
    modes = { "v" },
    short_name = "",
    auto_submit = true,
    user_prompt = false,
    stop_context_insertion = true,
  },
  prompts = {
    {
      role = "user",
      content = function(ctx)
        local text = require("codecompanion.helpers.actions").get_code(ctx.start_line, ctx.end_line)
        return string.format("Summarize following text in one one sentence.\n\nText: %s", text)
      end,
    },
  },
}
