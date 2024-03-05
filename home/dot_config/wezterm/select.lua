-- -*-mode:lua-*- vim:ft=lua
local pattern = require("regexp").pattern

return {
  alphabet = "hjklasdfgyuiopqwertnmzxcvb",
  patterns = {
    "[A-Za-z0-9-_.]{6,100}",
    pattern.url,
    pattern.ipv4,
    pattern.ipv6,
    pattern.email,
    pattern.hash,
    pattern.version,
  },
}
