-- -*-mode:lua-*- vim:ft=lua

local target_lang = "Japanese"

return {
  interaction = "chat", ---@type "inline"|"chat"
  description = "Correct grammar and reformulate",
  opts = {
    index = 16,
    is_default = true,
    modes = { "v" },
    short_name = "translate",
    auto_submit = true,
    user_prompt = false,
    stop_context_insertion = true,
  },
  prompts = {
    {
      role = "system",
      content = function(_)
        return string.format([[
I want you to act as an %s translator, spelling corrector and improver.
I will speak to you in any language and you will detect the language,
translate it and answer in the corrected and improved version of my text, in %s.
I want you to replace my simplified A0-level words and sentences with more beautiful and elegant,
upper level %s words and sentences.
Keep the meaning same, but make them more literary.
I want you to only reply the correction, the improvements and nothing else, do not write explanations."
        ]], target_lang, target_lang, target_lang)
      end,
    },
    {
      role = "user",
      content = function(ctx)
        local text = require("codecompanion.helpers.actions").get_code(ctx.start_line, ctx.end_line)
        return string.format([[
Please translate this text to %s.
Return the translation only and no markdown codeblocks:

%s
        ]], target_lang, text)
      end,
    },
  },
}
