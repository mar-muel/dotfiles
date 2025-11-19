sudo apt-get install -y tmux htop git rsync flake8 jq nmon git-lfs mosh fuse libfuse2

# install ripgrep
wget https://github.com/BurntSushi/ripgrep/releases/download/13.0.0/ripgrep_13.0.0_amd64.deb
sudo dpkg -i ripgrep_13.0.0_amd64.deb
rm ripgrep_13.0.0_amd64.deb

# Install mar-muel specific dotfiles
git clone https://github.com/mar-muel/dotfiles.git ~/dotfiles
cd ~/dotfiles && chmod +x set_ubuntu.sh && bash set_ubuntu.sh
cd ~ && source ~/.bashrc

# install neovim
curl -LO https://github.com/neovim/neovim/releases/download/v0.11.4/nvim-linux-x86_64.appimage
sudo mv nvim-linux-x86_64.appimage /usr/bin/nvim
sudo chmod +x /usr/bin/nvim
echo "alias vim='nvim'" >> .bash_aliases
mkdir -p ~/.config
cp -R ~/dotfiles/nvim/ ~/.config/nvim

# tmux setup
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm && ~/.tmux/plugins/tpm/scripts/install_plugins.sh

# Install uv
curl -LsSf https://astral.sh/uv/install.sh | sh

# install node
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
source ~/.bashrc
nvm install v20.9.0 && nvm use v20.9.0
