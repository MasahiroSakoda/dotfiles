-- -*-mode:lua-*- vim:ft=lua

return {
  strategy    = "inline", ---@type "inline"|"chat"
  description = "Add documentation to the selected code",
  opts = {
    index = 11,
    default_prompt = true,
    mapping = "<localLeader>ad",
    modes = { "v" },
    slash_cmd = "doc",
    auto_submit = true,
    user_prompt = false,
    stop_context_insertion = true,
  },
  prompt = {
    {
      role = "system", ---@type "system"|"user"
      content = [[
When asked to add documentation, follow these steps:
1. **Identify Key Points**: Carefully read the provided code to understand its functionality.
2. **Plan the Documentation**: Describe the key points to be documented in pseudocode, detailing each step.
3. **Implement the Documentation**: Write the accompanying documentation in the same file or a separate file.
4. **Review the Documentation**: Ensure that the documentation is comprehensive and clear. Ensure the documentation:
  - Includes necessary explanations.
  - Helps in understanding the code's functionality.
  - Add parameters, return values, and exceptions documentation.
  - Follows best practices for readability and maintainability.
  - Is formatted correctly.

Use Markdown formatting and include the programming language name at the start of the code block.]],
      opts = { visible = true },
    },
    {
      role = "user", ---@type "system"|"user"
      content = function(ctx)
        local code = require("codecompanion.helpers.actions").get_code(ctx.start_line, ctx.end_line)
        return string.format("Please document the selected code:\n\n```%s\n%s\n```\n\n",
          ctx.filetype, ctx.filetype, code)
      end,
      opts = { contains_code = true },
    },
  },
}
