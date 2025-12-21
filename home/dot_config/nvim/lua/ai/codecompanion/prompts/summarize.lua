-- -*-mode:lua-*- vim:ft=lua

return {
  strategy    = "chat", ---@type "inline"|"chat"
  description = "Summarize long text",
  opts = {
    index = 18,
    is_default = true,
    modes = { "v" },
    short_name = "summarize",
    auto_submit = true,
    user_prompt = true,
    stop_context_insertion = true,
  },
  prompts = {
    {
      role = "user",
      content = function(ctx)
        local text = require("codecompanion.helpers.actions").get_code(ctx.start_line, ctx.end_line)
        return string.format([[
1. Preserve all original ideas while making the content shorter and clearer.
Organize the summary by chapters, themes, or bullet points.
Match the tone of the original (e.g., raw, formal, motivational, etc.).
Revise it to get closer to 100% fidelity by restoring more quotes, names, and subtle details. **Show me full summary**
%s

2. Compare this full summary to original text, does this leave anything out? what is the percentage?
%s

3. Revise it to get closer to **100% fidelity**, **Show me full summary**.
Or it might simply ask you if you want to revise it, just simply reply "Yes, show me full summary."
        ]], text, text)
      end,
    },
  },
}
