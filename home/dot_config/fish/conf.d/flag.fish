# -*-mode:fish-*- vim:ft=fish

for pkg in openssl curl readline gettext ncurses sqlite zlib tcl-tk
  set -gx LDFLAGS  "-L$HOMEBREW_PREFIX/opt/$pkg/lib" $LDFLAGS
  set -gx CFLAGS "-I$HOMEBREW_PREFIX/opt/$pkg/include" $CFLAGS
  set -gx CPPFLAGS "-I$HOMEBREW_PREFIX/opt/$pkg/include" $CPPFLAGS
  set -gx PKG_CONFIG_PATH "$HOMEBREW_PREFIX/opt/$pkg/lib/pkgconfig" $PKG_CONFIG_PATH
end
