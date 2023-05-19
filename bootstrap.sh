#!/usr/bin/env bash
set -e

. bin/echo.sh
TARGET="${HOME}/.dotfiles"

is_executable() {
  type "$1" > /dev/null 2>&1
}

# Configure download command
download_cmd() {
  local SOURCE="https://github.com/MasahiroSakoda/dotfiles"
  local tarball="${SOURCE}/tarball/main"
  local tar_cmd="tar -xzv -C "${TARGET}" --strip-components=1 --exclude='{.gitignore}'"
  local cmd=""

  if is_executable "git"; then
    cmd="git clone ${SOURCE} ${TARGET}"
  elif is_executable "curl"; then
    cmd="curl -#L ${tarball} | ${tar_cmd}"
  elif is_executable "wget"; then
    cmd="wget --no-check-certificate -O - ${tarball} | ${tar_cmd}"
  fi

  info $cmd
}

# Clone resository
clone() {
  local cmd=$(download_cmd ${TARGET})

  if [ -z "$cmd" ]; then
    error "No git, curl or wget available. Aborting."
  else
    info "Installing dotfiles..."
    mkdir -p "${TARGET}"
    eval "${cmd}"
  fi
}

# Install Xcode
install_Xcode() {
  sudo softwareupdate -i -a

  info "Installing Xcode command line tools..."
  if xcode-select --print-path &>/dev/null; then
    substep_info "Xcode command line tools already installed."
  elif xcode-select --install &>/dev/null; then
    substep_success "Finished installing Xcode command line tools."
  else
    error "Failed to install Xcode command line tools."
  fi
}

main() {
  clone
  # Prompt password
  if [ -z "${GITHUB_ACTION+x}" ]; then
    info "Prompting for sudo password..."
    if sudo -v; then
      while true; do
        sudo -n true
        sleep 60
        kill -0 "$$" || exit
      done 2>/dev/null &
      success "sudo credentials updated."
    else
      error "Failed to obtain sudo credentials."
    fi
  fi
  install_Xcode
  cd "${TARGET}"

  make install
  make asdf
  make system
  make deploy
}

main 2>&1
