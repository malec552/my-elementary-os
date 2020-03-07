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
mkdir -p ~/.local/share/fonts
wget https://raw.githubusercontent.com/ryanoasis/nerd-fonts/master/patched-fonts/Hack/Regular/complete/Hack%20Regular%20Nerd%20Font%20Complete.ttf -o ~/.local/share/fonts/Hack%20Regular%20Nerd%20Font%20Complete.ttf
fc-cache -f -v

chsh -s $(which zsh)

