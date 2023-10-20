# -*-mode:fish-*- vim:ft=fish

# Rust
set -gx RUST_BACKTRACE full

# Ruby
set -gx RUBY_CFLAGS "-Wno-error=implicit-function-declaration"
set -gx RUBY_CONFIGURE_OPTS "--with-openssl-dir=$(brew --prefix openssl@3)"

# Node.js
set -gx NODE_ENV development

# pnpm
set -gx PNPM_HOME "$HOME/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
