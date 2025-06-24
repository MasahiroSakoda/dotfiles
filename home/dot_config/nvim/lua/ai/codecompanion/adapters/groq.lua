-- -*-mode:lua-*- vim:ft=lua
return function()
  return require("codecompanion.adapters").extend("openai", {
    url = "https://api.groq.com/openai/v1/chat/completions",
    schema = {
      ---@see https://console.groq.com/docs/models
      model = {
        default = "llama-3.3-70b-versatile",
        choices = {
          "llama-3.3-70b-versatile",
          "meta-llama/llama-guard-4-12b",
          "qwen/qwen3-32b",
          "deepseek-r1-distill-llama-70b",
        },
      },
      temperature = { default = 0.0 },
      max_tokens  = { default = 512 },
    },
    handlers = {
      form_messages = function(_, messages)
        local formatted_messages = {}
        for _, message in ipairs(messages) do
          table.insert(formatted_messages, { role = message.role, content = message.content })
        end
        return { messages = formatted_messages }
      end,
    },
    env = { api_key = vim.env.GROQ_API_KEY },
  })
end
