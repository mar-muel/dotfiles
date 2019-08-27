# Before running: make sure conda and vim are installed

# install stuff
conda install rsync tmux ncurses ripgrep -y
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

# tmux
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
# Then run prefix-I inside tmux

# vim
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim -c 'PluginInstall' -c 'qa!'
