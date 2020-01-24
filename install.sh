#!/bin/bash
set -xeu
# IFS=$'\n\t'

# install Linuxbrew, paste at a terminal prompt:
sh -c "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh)"

brew update
brew install zsh
brew install git vim jq tig fzf colorls

git clone https://github.com/ohmyzsh/ohmyzsh.git .oh-my-zsh
git clone https://github.com/A12o/cloudshell.git .cloudshell

rm -rf ~/.vimrc ~/.tmux.conf

ln -s ~/.cloudshell/Dotfiles/.vimrc ~/.vimrc
ln -s ~/.cloudshell/Dotfiles/.zshrc ~/.zshrc
ln -s ~/.cloudshell/profile.d ~/profile.d

cat >> ~/.bashrc << BOF
zsh
BOF

brew install ruby
gem install tmuxinator
ln -s ~/.cloudshell/Dotfiles/.tmux.conf ~/.tmux.conf
ln -s ~/.cloudshell/Dotfiles/.tmuxinator ~/.tmuxinator

echo -e "\n Restart Cloud Shell for changes to take effect"

exit
