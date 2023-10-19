# -*-mode:fish-*- vim:ft=fish

# GNU binutils
set -gx LDFLAGS "-L$HOMEBREW_PREFIX/opt/binutils/lib"
set -gx CPPFLAGS "-I$HOMEBREW_PREFIX/opt/binutils/include"

# zlib
set -gx LDFLAGS "-L$HOMEBREW_PREFIX/opt/zlib/lib"
set -gx CPPFLAGS "-I$HOMEBREW_PREFIX/opt/zlib/include"
set -gx PKG_CONFIG_PATH "$HOMEBREW_PREFIX/opt/zlib/lib/pkgconfig"

# Readline
set -gx LDFLAGS "-L$HOMEBREW_PREFIX/opt/readline/lib"
set -gx CPPFLAGS "-I$HOMEBREW_PREFIX/opt/readline/opt/readline/include"
set -gx PKG_CONFIG_PATH "$HOMEBREW_PREFIX/opt/readline/lib/pkgconfig"

# cURL
set -gx LDFLAGS "-L$HOMEBREW_PREFIX/opt/curl/lib"
set -gx CPPFLAGS "-I$HOMEBREW_PREFIX/opt/curl/include"
set -gx PKG_CONFIG_PATH "$HOMEBREW_PREFIX/opt/curl/lib/pkgconfig"

# libffi
set -gx LDFLAGS "-L$HOMEBREW_PREFIX/opt/libffi/lib"
set -gx CPPFLAGS "-I$HOMEBREW_PREFIX/opt/libffi/include"
set -gx PKG_CONFIG_PATH "$HOMEBREW_PREFIX/opt/libffi/lib/pkgconfig"
