local ok, neoai = pcall(require, "neoai")
if not ok then return end

neoai.setup({
  open_api_key_env = "OPENAI_API_KEY",

  ui = {
    input_popup_text  = "Prompt",
    output_popup_text = "NeoAI",
    width               = 30, -- As percentage eg. 30%
    output_popup_height = 80, -- As percentage eg. 80%
    submit = "<Enter>", -- Key binding to submit the prompt
  },

  models = {
    {
      name   = "openai",
      model  = "gpt-3.5-turbo", ---@Usage: "gpt-3.5-turbo", "gpt-4", "gpt-4-32k"
      params = nil,
    },
  },

  register_output = {
    ["g"] = function(output) return output end,
    ["c"] = require("neoai.utils").extract_code_snippets,
  },

  inject = {
    cutoff_width = 75,
  },

  prompts = {
    context_prompt = function(context)
      return "Hey, I'd like to provide some context for future "
        .. "messages. Here is the code/text that I want to refer "
        .. "to in our upcoming conversations:\n\n"
        .. context
    end,
  },

  shortcuts = {
    {
      name  = "textify",
      key   = "<Leader>as",
      desc  = "fix text with AI",
      modes = { "v" },
      use_context = true,
      prompt = [[
        Please rewrite the text to make it more readable, clear,
        concise, and fix any grammatical, punctuation, or spelling
        errors
      ]],
      strip_function = nil,
    },
    {
      name  = "refactor",
      key   = "<Leader>ar",
      desc  = "Improve code",
      modes = { "v" },
      use_context = true,
      Prompt = [[
        Refactor this code to make it more readable and maintainable,
        ensuring that best practices are used wherever practical.
      ]],
      strip_function = nil,
    },
    {
      name  = "gitcommit",
      key   = "<Leader>ag",
      desc  = "generate git commit message",
      modes = { "n" },
      use_context = false,
      prompt = [[
        Using the following git diff generate a consise and
        clear git commit message, with a short title summary
        that is 75 characters or less:
      ]] ..vim.fn.system("git diff --cached"),
      strip_function = nil,

    },
  },
})
