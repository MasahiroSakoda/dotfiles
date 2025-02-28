-- -*-mode:lua-*- vim:ft=lua
vim.g.local_llm = "qwen2.5-coder:7b"

return function()
  return require("codecompanion.adapters").extend("ollama", {
    name   = vim.split(vim.g.local_llm, ":", { trimempty = true })[1],
    schema = { model = { default = vim.g.local_llm } },
  })
end
