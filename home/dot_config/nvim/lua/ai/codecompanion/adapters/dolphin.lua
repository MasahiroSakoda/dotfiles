-- -*-mode:lua-*- vim:ft=lua

return function()
  return require("codecompanion.adapters").extend("ollama", {
    name   = "Dolphin 3.0 based Llama 3.1 8B",
    schema = { model = { default = "dolphin3:latest" } },
  })
end
