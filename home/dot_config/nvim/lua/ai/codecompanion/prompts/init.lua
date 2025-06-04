-- -*-mode:lua-*- vim:ft=lua

return {
  ["Documentation"]         = require("ai.codecompanion.prompts.documentation"),
  ["Refactor Code in chat"] = require("ai.codecompanion.prompts.refactor_chat"),
  ["Refactor Code inline"]  = require("ai.codecompanion.prompts.refactor_inline"),
  ["Review"]                = require("ai.codecompanion.prompts.review"),
  ["PullRequest"]           = require("ai.codecompanion.prompts.pull_request"),
  ["Correct Grammar"]       = require("ai.codecompanion.prompts.grammar"),
  ["Translate"]             = require("ai.codecompanion.prompts.translate"),
  ["Summarize"]             = require("ai.codecompanion.prompts.summarize"),
}
