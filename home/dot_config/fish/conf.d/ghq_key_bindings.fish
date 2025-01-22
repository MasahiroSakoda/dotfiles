# -*-mode:fish-*- vim:ft=fish

bind \cg "__ghq_browse_repository"
if bind -M insert >/dev/null 2>/dev/null
  bind -M insert \cg "__ghq_browse_repository"
end
