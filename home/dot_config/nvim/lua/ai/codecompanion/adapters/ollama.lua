-- -*-mode:lua-*- vim:ft=lua
return function()
  return require("codecompanion.adapters").extend("ollama", {
    name   = "mistral",
    schema = { model = { default = vim.g.local_llm } },
  })
end
