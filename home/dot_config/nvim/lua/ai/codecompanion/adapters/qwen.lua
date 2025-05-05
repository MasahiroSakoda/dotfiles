-- -*-mode:lua-*- vim:ft=lua

return function()
  return require("codecompanion.adapters").extend("ollama", {
    name   = "Qwen 3 8b",
    schema = { model = { default = "qwen3:8b" } },
  })
end
