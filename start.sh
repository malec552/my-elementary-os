#!/usr/bin/env bash

printf "\n%s [START]\n\n" "initializing your os..."

sudo apt-get update && sudo apt-get upgrade -y
sudo apt-get install -y openssh-server software-properties-common
sudo add-apt-repository -y ppa:teejee2008/ppa
sudo apt-get update
sudo apt-get install -y terminator timeshift git curl zsh htop vim

# install bat - cat with wings :)
BAT_VERSION=$(curl -s "https://api.github.com/repos/sharkdp/bat/releases/latest" | grep '"tag_name":' | sed -E 's/.*"v([^"]+)".*/\1/')

wget https://github.com/sharkdp/bat/releases/download/v"$BAT_VERSION"/bat_"$BAT_VERSION"_amd64.deb
sudo dpkg -i bat_"$BAT_VERSION"_amd64.deb
rm bat_"$BAT_VERSION"_amd64.deb

# install lsd - ls on steroids :)
LSD_VERSION=$(curl -s "https://api.github.com/repos/Peltoche/lsd/releases/latest" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')

wget https://github.com/Peltoche/lsd/releases/download/$LSD_VERSION/lsd_"$LSD_VERSION"_amd64.deb
sudo dpkg -i lsd_"$LSD_VERSION"_amd64.deb
rm ~/lsd_"$LSD_VERSION"_amd64.deb

# oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" "" --unattended

# oh-my-zsh plugins, themes
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k

# some config
mkdir -p ~/.config/terminator
wget https://raw.githubusercontent.com/adrianmalec/my-elementary-os/master/terminator-config -O ~/.config/terminator/config
wget https://raw.githubusercontent.com/adrianmalec/my-elementary-os/master/universal-zshrc -O ~/.zshrc
wget https://raw.githubusercontent.com/adrianmalec/my-elementary-os/master/powerlevel9k-config -O ~/.zshrc_powerlevel9k
wget https://raw.githubusercontent.com/adrianmalec/my-elementary-os/master/zshrc-aliases -O ~/.zshrc_aliases

# install nerd fonts

mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts && curl -fLo "Droid Sans Mono for Powerline Nerd Font Complete.otf" https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/DroidSansMono/complete/Droid%20Sans%20Mono%20Nerd%20Font%20Complete.otf
fc-cache -f -v
cd ~/

# vim
sh <(curl https://j.mp/spf13-vim3 -L)

cat <<EOF > ~/.vimrc.local
set nospell
set nolist
let g:go_fmt_command = "goimports"
let g:NERDTreeWinPos = "left"
autocmd vimenter * if !argc() | NERDTree | endif
EOF

printf "\n%s [DONE]\n" "... initialized"
