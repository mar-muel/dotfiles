#!/usr/bin/env bash
# Bootstrap a brand-new Mac from nothing. Safe to re-run.
set -euo pipefail

# --- 1. Xcode Command Line Tools --------------------------------------------
# Provides git and the C compiler that homebrew and treesitter parsers need.
if ! xcode-select -p >/dev/null 2>&1; then
  echo "==> Installing Xcode Command Line Tools"
  xcode-select --install
  echo "    Accept the GUI prompt, wait for it to finish, then re-run this script."
  exit 1
fi

# --- 2. Homebrew ------------------------------------------------------------
if ! command -v brew >/dev/null 2>&1; then
  echo "==> Installing Homebrew"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
eval "$(/opt/homebrew/bin/brew shellenv)"

# --- 3. oh-my-zsh -----------------------------------------------------------
# mac/zshrc sources it, so it has to exist first. KEEP_ZSHRC stops the
# installer from clobbering the .zshrc that set_mac.sh is about to write.
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "==> Installing oh-my-zsh"
  RUNZSH=no KEEP_ZSHRC=yes sh -c \
    "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# --- 4. this repo -----------------------------------------------------------
# https, not ssh: a fresh Mac has no keys on github yet.
if [ ! -d "$HOME/dotfiles" ]; then
  echo "==> Cloning dotfiles"
  git clone https://github.com/mar-muel/dotfiles.git ~/dotfiles
fi

# --- 5. tmux plugin manager -------------------------------------------------
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
  echo "==> Installing tpm"
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

# --- 6. config + tools ------------------------------------------------------
cd ~/dotfiles && bash set_mac.sh

echo
echo "==> Bootstrap complete."
echo "    Switch the repo to ssh once your key is on github:"
echo "    git -C ~/dotfiles remote set-url origin git@github.com:mar-muel/dotfiles.git"
