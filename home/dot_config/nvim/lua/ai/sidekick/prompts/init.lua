-- -*-mode:lua-*- vim:ft=lua

---@type table<string, sidekick.Prompt|string|fun(ctx:sidekick.context.ctx):(string?)>
return {
  changes         = "Review my staged changes",
  diagnostics     = "Can you help me fix the diagnostics in {file}?\n{diagnostics}",
  diagnostics_all = "Can you help me fix these diagnostics?\n{diagnostics_all}",
  review          = "Review {file} for any issues or improvements",
  refactor        = "Refactor {this} to be more maintainable",
  security        = "Review {this} security vulnerabilities",
  tests           = "Generate test for {this}",
  optimize        = "Optimize the code {this}",
  explain         = "Explain {this}",
  commit          = "Generate conventional commit",
  document        = "Add documentation to {function|line}",
  summary         = "Summarize {this} within 10 items",
  translate       = "Translate {this} to Japanese",
  spell           = "Fix the spelling mistake in {file}",
  grammar         = "Review {this} grammar and suggest improvements",

  -- simple context prompts
  buffers         = "{buffers}",
  file            = "{file}",
  line            = "{line}",
  position        = "{position}",
  quickfix        = "{quickfix}",
  selection       = "{selection}",
  ["function"]    = "{function}",
  class           = "{class}",
}
