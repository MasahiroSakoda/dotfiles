-- -*-mode:lua-*- vim:ft=lua

return function()
  return require("codecompanion.adapters").extend("ollama", {
    name   = "Qwen models",
    schema = {
      model = {
        default = "goekdenizguelmez/JOSIEFIED-Qwen3:8b",
        choices = { "goekdenizguelmez/JOSIEFIED-Qwen3:8b" },
      },
    },
  })
end
