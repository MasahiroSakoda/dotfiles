-- -*-mode:lua-*- vim:ft=lua
return function()
  return require("codecompanion.adapters").extend("anthropic", {
    schema = {
      ---@see https://docs.anthropic.com/en/docs/about-claude/models
      model = {
        default = "claude-3-7-sonnet-latest",
        choices = {
          ["claude-3-5-sonnet-latest"] = { opts = { can_reason = true, can_use_tools = true, has_vision = true } },
          ["claude-3-7-sonnet-latest"] = { opts = { can_reason = true, can_use_tools = true, has_vision = true } },
          ["claude-sonnet-4-20250514"] = { opts = { can_reason = true, can_use_tools = true, has_vision = true } },
        },
      },
    },
    env = { api_key = vim.env.ANTHROPIC_API_KEY },
  })
end
