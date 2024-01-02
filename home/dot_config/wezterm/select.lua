-- -*-mode:lua-*- vim:ft=lua
local regexp = require("regexp")

return {
  alphabet = "hjklasdfgyuiopqwertnmzxcvb",
  patterns = {
    "[A-Za-z0-9-_.]{6,100}",
    regexp.pattern.url,
    regexp.pattern.ip,
    regexp.pattern.email,
    regexp.pattern.hash,
    regexp.pattern.version,
  },
}
