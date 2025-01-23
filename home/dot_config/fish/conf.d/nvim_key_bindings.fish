# -*-mode:fish-*- vim:ft=fish

bind \cx "__nvim_browse_plugin"
if bind -M insert >/dev/null 2>/dev/null
  bind -M insert \cx "__nvim_browse_plugin"
end
