rsync --progress ubuntu/vimrc ~/.vimrc 
rsync --progress ubuntu/bash_aliases ~/.bash_aliases 
rsync --progress ubuntu/gitconfig ~/.gitconfig
rsync --progress ubuntu/bashrc ~/.bashrc 
rsync --progress ubuntu/tmux.conf ~/.tmux.conf
rsync --progress ubuntu/condarc ~/.condarc
rsync --progress ubuntu/inputrc ~/.inputrc
mkdir -p ~/.config && rsync --progress ubuntu/flake8 ~/.config/flake8
