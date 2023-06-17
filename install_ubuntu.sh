#!/usr/bin/env bash

# good ol update
sudo apt update && sudo apt upgrade -y

# Install some general tools
sudo apt-get install -y tmux htop git rsync flake8 jq nmon git-lfs mosh

# Install neovim
sudo add-apt-repository -y ppa:neovim-ppa/unstable
sudo apt-get update
sudo apt-get install -y neovim python3-neovim

# Install ripgrep
wget https://github.com/BurntSushi/ripgrep/releases/download/13.0.0/ripgrep_13.0.0_amd64.deb
sudo dpkg -i ripgrep_13.0.0_amd64.deb
rm ripgrep_13.0.0_amd64.deb

# Install mar-muel specific dotfiles
git clone https://github.com/mar-muel/dotfiles.git ~/dotfiles
cd ~/dotfiles && chmod +x set_ubuntu.sh && bash set_ubuntu.sh
cd ~ && source ~/.bashrc

# vim setup
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
nvim +PlugInstall +qall

# install Vundle (vim)
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# tmux setup
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm && ~/.tmux/plugins/tpm/scripts/install_plugins.sh

# Install miniconda
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh
bash ~/miniconda.sh -b -p $HOME/miniconda
$HOME/miniconda/bin/conda init bash
source ~/.bashrc
rm ~/miniconda.sh
