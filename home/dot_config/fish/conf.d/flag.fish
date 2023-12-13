# -*-mode:fish-*- vim:ft=fish

for pkg in ncurses sqlite curl
  set -gx LDFLAGS "-L$HOMEBREW_PREFIX/opt/$pkg/lib" $LDFLAGS
  set -gx CPPFLAGS "-I$HOMEBREW_PREFIX/opt/$pkg/include" $CPPFLAGS
  set -gx PKG_CONFIG_PATH "$HOMEBREW_PREFIX/opt/$pkg/lib/pkgcofig" $PKG_CONFIG_PATH
end
