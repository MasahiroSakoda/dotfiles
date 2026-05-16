# -*-mode:zsh-*- vim:ft=zsh

function git() {
  if [[ "$1" == "commit" ]]; then
    for arg in "$@"; do
      if [[ "$arg" == "--no-verify" || "$arg" == "-n" ]]; then
        echo "❌ ERROR: --no-verify bypasses quality checks and is forbidden"
        echo "Pre-commit hooks ensure code quality. Please fix issues instead of bypassing them."
        return 1
      fi
    done
  fi
  command git "$@"
}
