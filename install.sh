#!/bin/bash
# set -xeu
# IFS=$'\n\t'

sh -c "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh)"

export PATH="/home/linuxbrew/.linuxbrew/bin":$PATH
brew update
brew install zsh
brew install vim jq tig fzf git httpie

rm -rf ~/.vimrc ~/.tmux.conf ~/.tmuxinator ~/.zshrc ~/profile.d ~/.ohmyzsh ~/.cloudshell

git clone https://github.com/ohmyzsh/ohmyzsh.git .oh-my-zsh
git clone https://github.com/A12o/cloudshell.git .cloudshell

ln -s ~/.cloudshell/Dotfiles/.vimrc ~/.vimrc
ln -s ~/.cloudshell/Dotfiles/.zshrc ~/.zshrc
ln -s ~/.cloudshell/profile.d ~/profile.d

cat >> ~/.bashrc << BOF
export PATH="/home/linuxbrew/.linuxbrew/bin":$PATH
cp -pR $HOME/linuxbrew /home/linuxbrew
bash -c zsh
BOF

rm -rf $HOME/linuxbrew
cp -pR /home/linuxbrew $HOME/

# brew install ruby
gem install tmuxinator
ln -s ~/.cloudshell/Dotfiles/.tmux.conf ~/.tmux.conf
ln -s ~/.cloudshell/Dotfiles/.tmuxinator ~/.tmuxinator

# echo -e "\n Restart Cloud Shell for changes to take effect"
source $HOME/.bashrc

