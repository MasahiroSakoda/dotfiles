# -*-mode:fish-*- vim:ft=fish

bind \cg "__ghq_browse_repository"
if bind --mode insert >/dev/null 2>/dev/null
  bind --mode insert \cg "__ghq_browse_repository"
end
