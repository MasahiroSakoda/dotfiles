-- -*-mode:lua-*- vim:ft=lua

return {
  alphabet = "",
  patterns = {
    "[A-Za-z0-9-_.]{6,100}",
    "\\b\\w+://[\\w.-]+\\.[a-z]{2,15}\\S*\\b",    -- URI
    [[\b\w+://(?:[\d]{1,3}\.){3}[\d]{1,3}\S*\b]], -- IP Address
    [[\b\w+@[\w-]+(\.[\w-]+)+\b]],                -- Email
    "sha256-[0-9a-zA-z=/+]{44}",                  -- sri hash
    "[0-9a-z]{52}",                               -- sha256
    [[v?\d+(?:\.\d+)+]],                          -- version
  },
}
