#!/bin/bash

# Upgrade the system
sudo apt upgrade

# Install ZSH
sudo apt install zsh

echo "Installed version $(zsh --version)"

# Make ZSH your default terminal using change shell (chsh)
chsh -h $(which zsh)

# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# Install zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# Install poweline fonts to be able to set them from preferences
git clone https://github.com/powerline/fonts.git --depth=1
cd fonts
./install.sh
cd ..
rm -rf fonts

CONFIG_DIR=$HOME/.config/zsh
mkdir $CONFIG_DIR
BACKUP_DIR=$HOME/devsetupbackup/init
rm -rf $BACKUP_DIR && mkdir -p $BACKUP_DIR
[-f $CONFIG_DIR] && mv $CONFIG_DIR $BACKUP_DIR
cp ./config/.zshrc $CONFIG_DIR/.zshrc
cp ./config/.zshenv $HOME/.zshenv

source $CONFIG_DIR/.zshrc

