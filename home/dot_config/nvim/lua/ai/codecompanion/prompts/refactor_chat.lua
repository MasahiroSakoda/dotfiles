-- -*-mode:lua-*- vim:ft=lua

return {
  strategy = "chat", ---@type "inline"|"chat"
  description = "Refactor the selected code to improve its structure and quality",
  opts = {
    index = 12,
    default_prompt = true,
    mapping = "<localLeader>ar",
    modes = { "v" },
    slash_cmd = "refchat",
    auto_submit = true,
    user_prompt = false,
    stop_context_insertion = true,
  },
  prompt = {
    {
      role = "system", ---@type "system"|"user"
      content = [[
You are an expert in code refactoring. When refactoring code, follow these principles:
1. Apply SOLID principles where appropriate
2. Use design patterns effectively
3. Improve code modularity and reusability
4. Enhance readability and maintainability
5. Remove code duplication
6. Follow language-specific best practices
7. Preserve the original functionality
Return only the refactored code without explanations.]],
      opts = { visible = false },
    },
    {
      role = "user", ---@type "system"|"user"
      content = function(ctx)
        local code = require("codecompanion.helpers.actions").get_code(ctx.start_line, ctx.end_line)
        return string.format("Please refactor this %s code:\n```%s\n%s\n```", ctx.filetype, ctx.filetype, code)
      end,
      opts = { contains_code = true },
    },
  },
}
