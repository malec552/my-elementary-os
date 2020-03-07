#!/usr/bin/env bash

LSD_VERSION=0.16.0

printf "\n%s [START]\n\n" "initializing your os..."

apt-get update && apt-get upgrade -y
apt-get install -y openssh-server software-properties-common
add-apt-repository -y ppa:teejee2008/ppa
apt-get update
apt-get install -y terminator timeshift git curl zsh

sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" "" --unattended
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k
wget https://github.com/Peltoche/lsd/releases/download/$LSD_VERSION/lsd_"$LSD_VERSION"_amd64.deb
dpkg -i lsd_"$LSD_VERSION"_amd64.deb

wget https://raw.githubusercontent.com/adrianmalec/my-elementary-os/master/terminator-config -O ~/.config/terminator/config
wget https://raw.githubusercontent.com/adrianmalec/my-elementary-os/master/universal-zshrc -O ~/.zshrc
wget https://raw.githubusercontent.com/adrianmalec/my-elementary-os/master/powerlevel9k-config -O ~/.zshrc_powerlevel9k
wget https://raw.githubusercontent.com/adrianmalec/my-elementary-os/master/zshrc-aliases -O ~/.zshrc_aliases

chsh -s $(which zsh)
zsh
source ~/.zshrc

