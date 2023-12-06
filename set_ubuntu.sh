rsync ubuntu/vimrc ~/.vimrc
rsync ubuntu/bash_aliases ~/.bash_aliases
rsync ubuntu/gitconfig ~/.gitconfig
rsync ubuntu/bashrc ~/.bashrc
rsync ubuntu/tmux.conf ~/.tmux.conf
rsync ubuntu/condarc ~/.condarc
rsync ubuntu/inputrc ~/.inputrc
mkdir -p ~/.config && rsync ubuntu/flake8 ~/.config/flake8
