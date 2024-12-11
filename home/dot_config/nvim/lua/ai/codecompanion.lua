-- -*-mode:lua-*- vim:ft=lua
local ok, codecompanion = pcall(require, "codecompanion")
if not ok then return end

require("utils.ai")

codecompanion.setup({
  opts = {
    log_level = "TRACE",   ---@type "DEBUG"|"TRACE"
    language  = "English", ---@type "English"|"Japanese"
  },

  prompt_library = {
    ["Documentation"] = {
      strategy = "inline", ---@type "inline"|"chat"
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
          content = function(context)
            local code = require("codecompanion.helpers.actions").get_code(context.start_line, context.end_line)
            return "Please document the selected code:\n\n```" .. context.filetype .. "\n" .. code .. "\n```\n\n"
          end,
          opts = { contains_code = true },
        },
      },
    },
    ["Refactor"] = {
      strategy = "chat", ---@type "inline"|"chat"
      description = "Refactor the selected code for readability, maintainability and performances",
      opts = {
        index = 12,
        default_prompt = true,
        mapping = "<localLeader>ar",
        modes = { "v" },
        slash_cmd = "refactor",
        auto_submit = true,
        user_prompt = false,
        stop_context_insertion = true,
        prompt = {
          {
            role = "system", ---@type "system"|"user"
            content = [[
When asked to optimize code, follow these steps:
1. **Analyze the Code**: Understand the functionality and identify potential bottlenecks.
2. **Implement the Optimization**: Apply the optimizations including best practices to the code.
3. **Shorten the code**: Remove unnecessary code and refactor the code to be more concise.
3. **Review the Optimized Code**: Ensure the code is optimized for performance and readability. Ensure the code:
  - Maintains the original functionality.
  - Is more efficient in terms of time and space complexity.
  - Follows best practices for readability and maintainability.
  - Is formatted correctly.

Use Markdown formatting and include the programming language name at the start of the code block.]],
            opts = { visible = false },
          },
          {
            role = "user", ---@type "system"|"user"
            content = function(context)
              local code = require("codecompanion.helpers.actions").get_code(context.start_line, context.end_line)
              return "Please optimize the selected code:\n\n```" .. context.filetype .. "\n" .. code .. "\n```\n\n"
            end,
            opts = { contains_code = true },
          }
        },
      },
    },
    ["PullRequest"] = {
      strategy = "chat",
      description = "Generate a Pull Request message description",
      opts = {
        index = 13,
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
\n\n```diff\n
            ]], vim.fn.system("git diff $(git merge-base HEAD main)") .. "\n```")
          end,
        },
      },
    },
  },

  adapters = {
    openai = function()
      return require("codecompanion.adapters").extend("openai", {
        schema = {
          model = {
            ---@see https://platform.openai.com/docs/models
            ---@type "gpt-3.5-turbo"|"gpt-4o"|"gpt-4o-mini"
            default = "gpt-4o-mini",
          },
        },
        env = {
          api_key = vim.env.OPENAI_API_KEY,
        },
      })
    end,

    anthropic = function()
      return require("codecompanion.adapters").extend("anthropic", {
        schema = {
          model = {
            ---@see https://docs.anthropic.com/en/docs/about-claude/models
            ---@type "claude-3-5-sonnet-latest"|"claude-3.5-haiku-latest"
            default = "claude-3-5-sonnet-latest",
          },
        },
        env = {
          api_key = vim.env.ANTHROPIC_API_KEY,
        },
      })
    end,

    ollama = function()
      return require("codecompanion.adapters").extend("ollama", {
        name   = "mistral",
        schema = {
          model = {
            default = vim.g.local_llm,
          },
        },
      })
    end,
  },

  strategies = {
    chat   = {
      adapter = "ollama",
    },
    inline = {
      adapter = "ollama",
    },
    agent  = {
      adapter = "ollama",
    },
  },
})
