-- -*-mode:lua-*- vim:ft=lua

return {
  default = {
    description = "Collection of common files for all projects",
    files = {
      ".clinerules",
      ".cursorrules",
      ".goosehints",
      ".rules",
      ".windsurfrules",
      ".github/copilot-instructions.md",
      "AGENT.md",
      "AGENTS.md",
      { path = "CLAUDE.md",           parser = "claude" },
      { path = "CLAUDE.local.md",     parser = "claude" },
      { path = "~/.claude/CLAUDE.md", parser = "claude" },
    },
    is_preset = true,
    opts = {
      chat = {
        enabled = true,
        defaults_rules = "default", -- The rule groups to load
      }
    },
  },
  -- claude  = {
  --   description = "Rules for Claude Code users",
  --   parser = "claude",
  --   files = {"CLAUDE.md"},
  -- },
  -- gemini  = {
  --   description = "Rules for Gemini CLI users",
  --   parser = "gemini",
  --   files = {"GEMINI.md"},
  -- },
}
