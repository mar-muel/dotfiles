#!/usr/bin/env bash
# Push this repo's macOS config onto the current machine. Safe to re-run.
set -euo pipefail
cd "$(dirname "$0")"

# --- dotfiles ---------------------------------------------------------------
rsync --progress mac/gitconfig ~/.gitconfig
rsync --progress mac/tmux.conf ~/.tmux.conf
rsync --progress mac/zshrc ~/.zshrc

# --- GUI apps + zsh + mise itself (homebrew) --------------------------------
rsync --progress mac/Brewfile ~/Brewfile
brew bundle --file="$HOME/Brewfile"

# --- CLI tools + language runtimes (mise) -----------------------------------
mkdir -p ~/.config/mise
rsync --progress mac/mise.toml ~/.config/mise/config.toml
mise install

# --- neovim -----------------------------------------------------------------
bash set_nvim.sh
# through `mise exec` so this does not depend on shell activation, which only
# applies to interactive shells and would not be in effect inside this script
mise exec -- nvim --headless "+Lazy! sync" +qa || true

echo
echo "==> Done. Open a new terminal for mise to take effect."
echo "    tmux: prefix + I installs plugins"
echo "    nvim: first launch compiles treesitter parsers"
