-- -*-mode:lua-*- vim:ft=lua

return {
  pattern = {
    line    = "^.+$",
    ipv4    = "([0-9]{1.3}\\.){3}[0-9]{1,3}(:[0-9]{1,5})?",
    url     = "\\b\\w+://[\\w.-]+\\.[a-z]{2,15}\\S*\\b",
    http    = "https?://\\S+\\b",
    git     = "git://\\S+\\b",
    ssh     = "ssh://\\S+\\b",
    ftp     = "ftp://\\S+\\b",
    file    = "file://\\S+\\b",
    mailto  = "mailto://\\S+\\b",
    email   = "\\b\\w+@[\\w-]+(\\.[\\w-]+)+\\b",
    hash    = "(sha256-[0-9a-zA-z=/+]{44}|[0-9a-f]{7,40}|[0-9a-z]{52})",
    version = "v?\\d+(?:\\.\\d+)+",
  },
}
