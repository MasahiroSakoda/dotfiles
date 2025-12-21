-- -*-mode:lua-*- vim:ft=lua

return {
  strategy    = "chat",
  description = "Generate a Pull Request message description",
  opts = {
    index = 14,
    default_prompt = true,
    mapping = "<localLeader>cp",
    slash_cmd = "pr",
    auto_submit = true,
  },
  prompts = {
    {
      role = "user",
      contains_code = true,
      content = function()
        return string.format([[
You are an expert at writing detailed and clear pull request descriptions
Please create a pull request message following standard convention from the provided diff changes.
Ensure the title, description, type of change, checklist, related issues,
and additional notes sections are well-structured and informative.

```diff
%s
```
        ]], vim.fn.system("git diff $(git merge-base HEAD main)...HEAD"))
      end,
    },
  },
}
