-- -*-mode:lua-*- vim:ft=lua
local ok, mcphub = pcall(require, "mcphub")
if not ok then return end

mcphub.setup({
  port   = 37373,
  config = vim.fn.expand("~/.config/mcphub/servers.json"),

  -- Optinal functions
  -- on_ready = function(hub)
  -- end,
  -- on_error = function(err)
  -- end,

  log = {
    level     = vim.log.levels.WARN,
    to_file   = false,
    file_path = nil,
    prefix = "MCPHub",
  },
})
