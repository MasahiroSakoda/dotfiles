-- -*-mode:lua-*- vim:ft=lua

---@type table<string, sidekick.Prompt|string|fun(ctx:sidekick.context.ctx):(string?)>
return {
  changes         = "Can you review my changes?",
  diagnostics     = "Can you help me fix the diagnostics in {file}?\n{diagnostics}",
  diagnostics_all = "Can you help me fix these diagnostics?\n{diagnostics_all}",
  document        = "Add documentation to {function|line}",
  explain         = "Explain {this}",
  fix             = "Can you fix {this}?",
  optimize        = "How can {this} be optimized?",
  review          = "Can you review {file} for any issues or improvements?",
  tests           = "Can you write tests for {this}?",

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
