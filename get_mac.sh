#!/usr/bin/env bash
# Pull the current machine's macOS config back into this repo.
set -euo pipefail
cd "$(dirname "$0")"

rsync --progress ~/.gitconfig mac/gitconfig
rsync --progress ~/.tmux.conf mac/tmux.conf
rsync --progress ~/.zshrc mac/zshrc

# CLI tools + language runtimes
rsync --progress ~/.config/mise/config.toml mac/mise.toml

# GUI apps + zsh + mise itself; regenerated from what brew actually has
brew bundle dump --file=mac/Brewfile --force

# neovim
bash get_nvim.sh
