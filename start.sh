#!/usr/bin/env bash

printf "\n%s [START]\n\n" "initializing your os..."

sudo apt-get update && sudo apt-get upgrade -y
sudo apt-get install -y openssh-server software-properties-common
sudo add-apt-repository -y ppa:teejee2008/ppa
sudo apt-get update
sudo apt-get install -y terminator timeshift git curl zsh

LSD_VERSION=$(curl -s "https://api.github.com/repos/Peltoche/lsd/releases/latest" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')

sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" "" --unattended
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k
wget https://github.com/Peltoche/lsd/releases/download/$LSD_VERSION/lsd_"$LSD_VERSION"_amd64.deb
sudo dpkg -i lsd_"$LSD_VERSION"_amd64.deb
rm ~/lsd_"$LSD_VERSION"_amd64.deb
mkdir -p ~/.config/terminator
wget https://raw.githubusercontent.com/adrianmalec/my-elementary-os/master/terminator-config -O ~/.config/terminator/config
wget https://raw.githubusercontent.com/adrianmalec/my-elementary-os/master/universal-zshrc -O ~/.zshrc
wget https://raw.githubusercontent.com/adrianmalec/my-elementary-os/master/powerlevel9k-config -O ~/.zshrc_powerlevel9k
wget https://raw.githubusercontent.com/adrianmalec/my-elementary-os/master/zshrc-aliases -O ~/.zshrc_aliases

printf "\n%s" "You need to download Hack Nerd Font and setup in terminator for lsd"
printf "\n%s [DONE]\n" "... initialized"
