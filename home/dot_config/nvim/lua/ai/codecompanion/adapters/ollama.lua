-- -*-mode:lua-*- vim:ft=lua

return function()
  return require("codecompanion.adapters").extend("ollama", {
    name   = "Cogito v1 preview",
    schema = { model = { default = "cogito:8b" } },
  })
end
