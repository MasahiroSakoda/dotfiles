-- -*-mode:lua-*- vim:ft=lua

return function()
  return require("codecompanion.adapters").extend("ollama", {
    name   = "Qwen 2.5 Coder 7b",
    schema = {
      model = {
        default = "qwen2.5-coder:7b",
        choices = { "qwen2.5-coder:7b", "goekdenizguelmez/JOSIEFIED-Qwen3:8b" },
      },
    },
  })
end
