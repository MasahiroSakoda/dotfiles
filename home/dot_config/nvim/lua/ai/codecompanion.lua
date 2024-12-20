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
          content = function(ctx)
            local code = require("codecompanion.helpers.actions").get_code(ctx.start_line, ctx.end_line)
            return string.format("Please document the selected code:\n\n```%s\n%s\n```\n\n",
              ctx.filetype, ctx.filetype, code)
          end,
          opts = { contains_code = true },
        },
      },
    },
    ["Refactor Code in chat"] = {
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
    },
    ["Refactor Code inline"] = {
      strategy = "inline", ---@type "inline"|"chat"
      description = "Refactor the selected code to improve its structure and quality",
      opts = {
        index = 12,
        is_default = true,
        modes = { "v" },
        short_name = "refinline",
        auto_submit = true,
        user_prompt = false,
        stop_context_insertion = true,
      },
      prompt = {
        {
          role = "system",
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
          role = "user",
          content = function(ctx)
            local code = require("codecompanion.helpers.actions").get_code(
              ctx.start_line,
              ctx.end_line,
              { show_line_numbers = true }
            )
            return string.format("Please refactor this %s code:\n```%s\n%s\n```", ctx.filetype, ctx.filetype, code)
          end,
          opts = { contains_code = true },
        }
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
    copilot = function()
      return require("codecompanion.adapters").extend("copilot", {
        schema = { ---@see https://github.com/copilot
          model = {
            default = "claude-3.5-sonnet", ---@type "gpt-4o"|"claude-3.5-sonnet"
          },
        },
      })
    end,

    openai = function()
      return require("codecompanion.adapters").extend("openai", {
        schema = { ---@see https://platform.openai.com/docs/models
          model = {
            default = "gpt-4o-mini", ---@type "gpt-3.5-turbo"|"gpt-4o"|"gpt-4o-mini"
          },
        },
        env = { api_key = vim.env.OPENAI_API_KEY },
      })
    end,

    anthropic = function()
      return require("codecompanion.adapters").extend("anthropic", {
        schema = { ---@see https://docs.anthropic.com/en/docs/about-claude/models
          model = {
            default = "claude-3-5-sonnet-latest", ---@type "claude-3-5-sonnet-latest"|"claude-3.5-haiku-latest"
          },
        },
        env = { api_key = vim.env.ANTHROPIC_API_KEY },
      })
    end,

    gemini = function()
      return require("codecompanion.adapters").extend("gemini", {
        schema = { ---@see https://ai.google.dev/gemini-api/docs/models/gemini
          model = {
            default = "gemini-1.5-pro", ---@type "gemini-1.5-flash"|"gemini-1.5-flash-8b"|"gemini-1.5-pro"
          },
        },
        env = { api_key = vim.env.GEMINI_API_KEY },
      })
    end,

    ollama = function()
      return require("codecompanion.adapters").extend("ollama", {
        name   = "mistral",
        schema = {
          model = { default = vim.g.local_llm },
        },
      })
    end,
  },

  strategies = {
    chat   = { adapter = "ollama" },
    inline = { adapter = "ollama" },
    agent  = { adapter = "ollama" },
  },

  display  = {
    chat = {
      render_headers = false,
      show_settings  = true,
    },
    diff = {
      layout   = "vertical", ---@type "horizontal"|"vertical"
      provider = "default",  ---@type "default"|"mini_diff"
    },
  },
})
