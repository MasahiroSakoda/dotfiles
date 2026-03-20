-- -*-mode:lua-*- vim:ft=lua
---@diagnostic disable: unused-local
local ls = require("luasnip")
local s  = ls.snippet
-- local t  = ls.text_node
local i  = ls.insert_node
-- local c  = ls.choice_node
-- local d  = ls.dynamic_node
-- local r  = ls.restore_node
-- local f  = ls.function_node
-- local sn = ls.snippet_node
local extras = require("luasnip.extras")
local rep    = extras.rep
-- local m      = extras.m
-- local l      = extras.l
local fmt     = require("luasnip.extras.fmt").fmt
local fmta    = require("luasnip.extras.fmt").fmta
-- local postfix = require("luasnip.extras.postfix").postfix
-- local conds   = require("luasnip.extras.conditions")
-- local condse  = require("luasnip.extras.conditions.expand")

local snippets = {
  s({ trig = "repo", name = "Repo Template", dscr = "Repo Template" },
    fmt([[
    README.md
    LICENSE
    .gitignore
    .markdownlint-cli2.yaml
    .editorconfig
    .github/CODEOWNERS
    .github/CONTRIBUTING.md
    .github/SECURITY.md
    .github/labeler.yml
    .github/ISSUE_TEMPLATE/config.yml
    .github/ISSUE_TEMPLATE/bug_report.yml
    .github/ISSUE_TEMPLATE/feature_request.yml
    .github/pull_request_tempalte.md
    ]], {})
  ),
  s({ trig = ";skills", name = "Agent Skills", dscr = "Agent Skills Template" },
    fmta([[
    .agents/skills/<>/SKILL.md
    .agents/skills/<>/references/
    .agents/skills/<>/scripts/
    <>
    ]], { i(1), rep(1), rep(1), i(0) })
  ),
  s({ trig = ";claude", name = "Claude Code", dscr = "Claude Code Template" },
    fmt([[
    .claude/agents/
    .claude/commands/
    .claude/rules/
    .claude/settings.json
    .claude/AGENTS.md
    ]], {})
  ),
  s({ trig = ";codex", name = "Codex CLI", dscr = "Codex CLI Template" },
    fmt([[
    .codex/agents/
    .codex/commands/
    .codex/rules/
    .codex/config.toml
    .codex/AGENTS.md
    ]], {})
  ),
  s({ trig = ";gemini", name = "Gemini CLI", dscr = "Gemini CLI Template" },
    fmt([[
    .gemini/agents/
    .gemini/commands/
    .gemini/policies/
    .gemini/rules/
    .gemini/settings.json
    .gemini/AGENTS.md
    .gemini/.geminiignore
    ]], {})
  ),
  s({ trig = ";opencode", name = "OpenCode", dscr = "OpenCode Template" },
    fmt([[
    .openocde/agent/
    .openocde/command/
    .openocde/rules/
    .openocde/tools/
    .opencode/oh-my-opencode.jsonc
    .opencode/opencode.jsonc
    .opencode/AGENTS.md

    ]], {})
  ),
}
return snippets
