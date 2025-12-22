-- -*-mode:lua-*- vim:ft=lua

return {
  strategy    = "inline", ---@type "inline"|"chat"
  description = "Correct grammar and reformulate",
  opts = {
    index = 15,
    is_default = true,
    modes = { "v" },
    short_name = "",
    auto_submit = true,
    user_prompt = false,
    stop_context_insertion = true,
  },
  prompts = {
    {
      role = "system",
      content = [[
I want you to act as an AI writing tutor.
I will provide you with a student who needs help improving their writing
and your task is to use artificial intelligence tools, such as natural language processing,
to give the student feedback on how they can improve their composition.

You should also use your rhetorical knowledge and experience about effective writing techniques
in order to suggest ways that the student can better express their thoughts and ideas in written form.
      ]],
      opts = { visible = false },
    },
    {
      role = "user",
      content = function(ctx)
        local text = require("codecompanion.helpers.actions").get_code(ctx.start_line, ctx.end_line)
        return string.format("Correct grammar and reformulate:\n\n%s", text)
      end,
      opts = { visible = false },
    },
  }
}
