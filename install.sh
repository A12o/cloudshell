#!/bin/bash
# set -xeu
# IFS=$'\n\t'

export PATH="/home/linuxbrew/.linuxbrew/bin":$PATH

sh -c "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh)"

brew update
brew install zsh
brew install vim jq tig fzf git httpie peco colordiff diff-so-fancy terraform sipcalc hexyl

rm -rf ~/.gitconfig ~/.vimrc ~/.tmux.conf ~/.tmuxinator ~/.zshrc ~/profile.d ~/.oh-my-zsh ~/.cloudshell

git clone https://github.com/ohmyzsh/ohmyzsh.git .oh-my-zsh
git clone https://github.com/A12o/cloudshell.git .cloudshell

ln -s ~/.cloudshell/Dotfiles/.vimrc ~/.vimrc
ln -s ~/.cloudshell/Dotfiles/.gitconfig ~/.gitconfig
ln -s ~/.cloudshell/Dotfiles/.zshrc ~/.zshrc
ln -s ~/.cloudshell/profile.d ~/profile.d

cat >> ~/.bashrc << BOF
export PATH="/home/linuxbrew/.linuxbrew/bin":$PATH
if [[ ! (-d /home/linuxbrew) ]]; then
  \echo -e "\n Please wait, copying missing linuxbrew files ...\n"
  # mkdir /home/linuxbrew
  cp -pR $HOME/.linuxbrew_bkp/linuxbrew /home/linuxbrew
  brew list
  brew upgrade
fi
bash -c zsh
BOF


rm -rf $HOME/.linuxbrew_bkp
mkdir $HOME/.linuxbrew_bkp
\echo -e "\n backing up linuxbrew ..."
cp -pR /home/linuxbrew -t $HOME/.linuxbrew_bkp

# brew install ruby
gem install tmuxinator
ln -s ~/.cloudshell/Dotfiles/.tmux.conf ~/.tmux.conf
ln -s ~/.cloudshell/Dotfiles/.tmuxinator ~/.tmuxinator

\echo -e "\n Restart Cloud Shell for changes to take effect \n\t or \n source ~/.bashrc"

