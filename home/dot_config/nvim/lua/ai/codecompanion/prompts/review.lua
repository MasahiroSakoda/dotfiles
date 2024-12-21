-- -*-mode:lua-*- vim:ft=lua

return {
  strategy    = "chat",
  description = "Review code in a buffer",
  opts = {
    modes = { "v" },
    short_name  = "review",
    slash_cmd   = "review",
    auto_submit = true,
    user_prompt = false,
    stop_context_insertion = true,
  },
  prompts = {
    {
      role = "system",
      contains_code = false,
      content = [[
Your task is to review the provided code snippet, focusing specifically on its readability and maintainability.
Identify any issues related to:
- Naming conventions that are unclear, misleading or doesn't follow conventions for the language being used.
- The presence of unnecessary comments, or the lack of necessary ones.
- Overly complex expressions that could benefit from simplification.
- High nesting levels that make the code difficult to follow.
- The use of excessively long names for variables or functions.
- Any inconsistencies in naming, formatting, or overall coding style.
- Repetitive code patterns that could be more efficiently handled through abstraction or optimization.

Your feedback must be concise, directly addressing each identified issue with:
- A clear description of the problem.
- A concrete suggestion for how to improve or correct the issue.

Format your feedback as follows:
- Explain the high-level issue or problem briefly.
- Provide a specific suggestion for improvement.

If the code snippet has no readability issues, simply confirm that the code is clear and well-written as is.
          ]],
      opts = { visible = false },
    },
    {
      role = "user",
      content = function(ctx)
        local code = require("codecompanion.helpers.actions").get_code(ctx.start_line, ctx.end_line)
        return string.format([[
Please review the following code and provide suggestions for improvement.
then refactor the following code to improve its clarity and readability:

```%s
%s
```
            ]], ctx.filetype, code)
      end,
      opts = { contains_code = true },
    },
  },
}
