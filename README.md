# Dotfiles
Personal config files

# Install
## macOS
On a brand-new machine run
```bash
cd && curl -sO https://raw.githubusercontent.com/mar-muel/dotfiles/master/install_mac.sh && bash install_mac.sh
```
This installs Xcode CLT, homebrew, oh-my-zsh, tpm, clones this repo and runs `set_mac.sh`.

On a machine that is already set up:
- `bash set_mac.sh` — push repo config onto the machine
- `bash get_mac.sh` — pull the machine's config back into the repo

What owns what on macOS:

| File | Installs to | Covers |
| --- | --- | --- |
| `mac/Brewfile` | `~/Brewfile` | GUI apps, zsh, mise itself |
| `mac/mise.toml` | `~/.config/mise/config.toml` | CLI tools and language runtimes |
| `mac/zshrc` | `~/.zshrc` | shell (activates mise) |
| `mac/gitconfig`, `mac/tmux.conf` | `~/.gitconfig`, `~/.tmux.conf` | git, tmux |
| `nvim/` | `~/.config/nvim/` | neovim |

## Ubuntu
SSH into new machine and run
```bash
cd && sudo apt-get update && sudo apt-get install -y curl && curl -sO https://raw.githubusercontent.com/mar-muel/dotfiles/master/install_ubuntu.sh && source install_ubuntu.sh
```
Same but using neovim instead of vim
```bash
cd && sudo apt-get update && sudo apt-get install -y curl && curl -sO https://raw.githubusercontent.com/mar-muel/dotfiles/master/install_ubuntu_nvim.sh  && source install_ubuntu_nvim.sh
```
