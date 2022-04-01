#!/usr/bin/env bash

# good ol update
sudo apt update && sudo apt upgrade -y

# Install some general tools
sudo apt-get install -y tmux vim-gtk htop git rsync flake8 jq nmon git-lfs

# Install mar-muel specific dotfiles
git clone https://github.com/mar-muel/dotfiles.git ~/dotfiles
cd ~/dotfiles && chmod +x set_ubuntu.sh && bash set_ubuntu.sh
cd ~ && source ~/.bashrc 

# vim setup
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall

# tmux setup
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm && ~/.tmux/plugins/tpm/scripts/install_plugins.sh

# Install miniconda
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh
bash ~/miniconda.sh -b -p $HOME/miniconda
$HOME/miniconda/bin/conda init bash
source ~/.bashrc
rm ~/miniconda.sh
