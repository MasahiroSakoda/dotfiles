-- -*-mode:lua-*- vim:ft=lua

return function()
  return require("codecompanion.adapters").extend("ollama", {
    name   = "JOSTIEFIED Qwen3 8b",
    schema = { model = { default = "goekdenizguelmez/JOSIEFIED-Qwen3:8b" } },
  })
end
