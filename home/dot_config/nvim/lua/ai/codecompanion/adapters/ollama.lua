-- -*-mode:lua-*- vim:ft=lua

return function()
  return require("codecompanion.adapters").extend("ollama", {
    name   = "Multi-purpose models",
    schema = { model = {
      default = "gemma3:4b",
      choices = { "gemma3:4b" },
    } },
  })
end
