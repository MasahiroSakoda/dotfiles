# -*-mode:fish-*- vim:ft=fish

bind \cx "__nvim_browse_plugin"
if bind --mode insert >/dev/null 2>/dev/null
  bind --mode insert \cx "__nvim_browse_plugin"
end
