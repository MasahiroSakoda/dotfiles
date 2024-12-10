-- -*-mode:lua-*- vim:ft=lua
return {
  -- NOTE: Blacklist for auto format
  format = {
    -- "lua_ls",
    "ts_ls",   -- to prevent conflict with biome
    -- "eslint",  -- to prevent conflict with biome
    "pyright", -- to prevent conflict with ruff
  },

  -- NOTE: Blacklist for snippet
  snippet = {
  },
}
