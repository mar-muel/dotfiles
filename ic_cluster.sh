rsync ./bash_profile ~/.bash_profile
rsync ./aliases ~/.aliases
rsync ./functions ~/.functions
source ~/.bash_profile

# install stuff
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

# vim
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
rsync ./vimrc ~/.vimrc
vim -c 'PluginInstall' -c 'qa!'


