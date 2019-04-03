# Before running: make sure conda and vim are installed

# git config
rsync ./gitconfig ~/.gitconfig

# conda config
conda config --add channels conda-forge 

# install stuff
conda install rsync tmux ncurses ripgrep -y
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

# sync profiles
rsync ./bash_profile ~/.bash_profile
rsync ./bash_aliases ~/.bash_aliases
rsync ./functions ~/.functions
rsync ./tmux.conf ~/.tmux.conf
source ~/.bash_profile

# vim
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
rsync ./vimrc ~/.vimrc
vim -c 'PluginInstall' -c 'qa!'
