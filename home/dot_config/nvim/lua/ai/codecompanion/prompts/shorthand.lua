-- -*-mode:lua-*- vim:ft=lua

return {
  strategy    = "chat", ---@type "inline"|"chat"
  description = "Express sentences in shorthand",
  opts = {
    index = 17,
    is_default = true,
    modes = { "v" },
    short_name = "shorthand",
    auto_submit = true,
    user_prompt = false,
    stop_context_insertion = true,
  },
  prompts = {
    {
      role = "system",
      content = function(_)
        return string.format([[
I want you to act as a professional summarize expert. When summarize text, follow these priciples:
1. Apply SOLID principles where appropriate
2. Use understandable word for highschool student
3. Organize the summary by chapters , themes, or bullet points.
4. Enhance readability
5. Remove duplication
6. Follow language-specific expression
7. Preserve the original ideas
Return only the summarized text without explanations.
        ]])
      end,
    },
    {
      role = "user",
      content = function(ctx)
        local text = require("codecompanion.helpers.actions").get_code(ctx.start_line, ctx.end_line)
        -- return string.format("Summarize following text in one one sentence.\n\nText: %s", text)
        return string.format([[
Summarize following text to bullet points within 10 lines.

%s
        ]], text)
      end,
    },
  },
}
