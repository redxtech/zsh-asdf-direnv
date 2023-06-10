#!/usr/bin/env zsh

# zsh plugin to load asdf & asdf-direnv

# set asdf install directory if not already specified
[[ -z "$ASDF_DIR" ]] && export ASDF_DIR="$HOME/.asdf"

# simple logging function
_zsh_asdf_direnv_log() {
  local weight=$1
  local colour=$2
  local msg=$3

  local format_start="%F{$colour}"
  local format_end="%f"

  if [ $weight = "bold" ]; then
    format_start="%B$format_start"
    format_end="$format_end%b"
  fi

  # print -P for proper formatting of %F & %B
  print -P "$format_start\[zsh-asdf-direnv] $msg$format_end"
}

# install direnv
_zsh_asdf_direnv_install_direnv() {
  _zsh_asdf_direnv_log "bold" "blue" "Installing direnv..."

  # make sure asdf is loaded
  source "$ASDF_DIR/asdf.sh"

  # if the direnv asdf plugin isn't installed, add it
  if ! asdf plugin list 2>/dev/null | grep direnv >/dev/null; then
    _zsh_asdf_direnv_log "none" "blue" "-> Adding plugin..."
    asdf plugin add direnv
  fi

  # if there isn't a version of direnv installed, install the latest
  if test ! "$(asdf list direnv 2>/dev/null | wc -l)" -gt 0; then
    _zsh_asdf_direnv_log "none" "blue" "-> Installing latest direnv..."
    asdf install direnv latest
    asdf global direnv latest
  fi

  _zsh_asdf_direnv_log "bold" "green" "-> direnv install OK"
}

# install asdf
_zsh_asdf_direnv_install_asdf() {
  _zsh_asdf_direnv_log "none" "blue" "#############################################"
  _zsh_asdf_direnv_log "bold" "blue" "Installing asdf..."
  _zsh_asdf_direnv_log "none" "blue" "-> cloning asdf into home dir: $ASDF_DIR"

  # if asdf isn't already installed, clone the repo
  if test -d "$ASDF_DIR"; then
    _zsh_asdf_direnv_log "bold" "blue" "-> asdf home dir already exists, skipping..."
  else
    # clone the repo to the home dir
    git clone https://github.com/asdf-vm/asdf.git "$ASDF_DIR"
    # checkout the latest release
    git -C "$ASDF_DIR" checkout -q "$(git -C $ASDF_DIR describe --abbrev=0 --tags)"

    # show the status of the install
    if test $? -ne 0; then
      _zsh_asdf_direnv_log "bold" "red" "-> asdf install failed."
    else
      _zsh_asdf_direnv_log "bold" "green" "-> asdf install OK"
    fi
  fi

  _zsh_asdf_direnv_log "none" "blue" "#############################################"
}

# source asdf and run the direnv hook, after adding completions to path
_zsh_asdf_direnv_load() {
  # if specified only load the asdf wrapper, leaving the shims out of path
  if test "$ZSH_ASDF_DIRENV_LIBONLY" = "true"; then
    PATH="$PATH:$ASDF_DIR/bin"
    source "$ASDF_DIR/lib/asdf.sh"
  else
    source "$ASDF_DIR/asdf.sh"
  fi

  eval "$(asdf exec direnv hook zsh)"
}

# if asdf isn't installed, install it
[[ ! -d "$ASDF_DIR" ]] && _zsh_asdf_direnv_install_asdf

local asdf_direnv_dir
asdf_direnv_dir="${ASDF_DATA_DIR:-"$ASDF_DIR/installs/direnv"}"

[[ ! -d "$asdf_direnv_dir" ]] && _zsh_asdf_direnv_install_direnv

# if asdf is installed, load it
[[ -d "$ASDF_DIR" ]] && _zsh_asdf_direnv_load
