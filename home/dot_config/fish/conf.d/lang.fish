# -*-mode:fish-*- vim:ft=fish

# Rust
set -gx RUST_BACKTRACE full

# Python
set -gx PYTHON_CONFIGURE_OPTS "--with-openssl-dir='$(brew --prefix openssl@3)' --with-readline-dir='$(brew --prefix readline)' --with-tcltk-includes='-I$(brew --prefix tcl-tk)/include' --with-tcltk-libs='-L$(brew --prefix tcl-tk)/lib -ltcl8.6 -ltk8.6'"

# Ruby
set -gx RUBY_CFLAGS "-Wno-error=implicit-function-declaration"
set -gx RUBY_CONFIGURE_OPTS "--with-openssl-dir=$(brew --prefix openssl@3) --with-readline-dir=$(brew --prefix readline)"

# pnpm
set -gx PNPM_HOME "$HOME/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
