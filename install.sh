#!/bin/bash
# install Linuxbrew, paste at a terminal prompt:
sh -c "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh)"

brew update
brew install zsh
brew install git vim jq tig

git clone https://github.com/ohmyzsh/ohmyzsh.git .oh-my-zsh
git clone https://github.com/A12o/cloudshell.git

rm -rf ~/.vimrc ~/.tmux.conf

ln -s ~/cloudshell/Dotfiles/.vimrc ~/.vimrc
ln -s ~/cloudshell/Dotfiles/.zshrc ~/.zshrc
ln -s ~/cloudshell/profile.d ~/profile.d

cat >> ~/.bashrc << BOF
bash -c zsh
BOF

gem install tmuxinator
ln -s ~/cloudshell/Dotfiles/.tmux.conf ~/.tmux.conf
ln -s ~/cloudshell/Dotfiles/.tmuxinator ~/.tmuxinator

exit
