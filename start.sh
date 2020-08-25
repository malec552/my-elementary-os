#!/usr/bin/env bash

printf "\n%s [START]\n\n" "initializing your os..."

sudo apt-get update && sudo apt-get upgrade -y > /dev/null
sudo apt-get install -y openssh-server software-properties-common > /dev/null
sudo add-apt-repository -y ppa:teejee2008/ppa > /dev/null
sudo apt-get update > /dev/null
sudo apt-get install -y terminator timeshift git curl zsh htop vim vim-gtk3 > /dev/null

printf "\n%s\n" "installig bat..."

# install bat - cat with wings :)
BAT_VERSION=$(curl -s "https://api.github.com/repos/sharkdp/bat/releases/latest" | grep '"tag_name":' | sed -E 's/.*"v([^"]+)".*/\1/')

wget -q https://github.com/sharkdp/bat/releases/download/v"$BAT_VERSION"/bat_"$BAT_VERSION"_amd64.deb
sudo dpkg -i bat_"$BAT_VERSION"_amd64.deb
rm bat_"$BAT_VERSION"_amd64.deb

# install lsd - ls on steroids :)

printf "\n%s\n" "installig lsd..."

LSD_VERSION=$(curl -s "https://api.github.com/repos/Peltoche/lsd/releases/latest" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')

wget -q https://github.com/Peltoche/lsd/releases/download/$LSD_VERSION/lsd_"$LSD_VERSION"_amd64.deb
sudo dpkg -i lsd_"$LSD_VERSION"_amd64.deb > /dev/null
rm ~/lsd_"$LSD_VERSION"_amd64.deb > /dev/null

# oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" "" --unattended

# oh-my-zsh plugins, themes
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions > /dev/null
git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k > /dev/null

# some config
mkdir -p ~/.config/terminator
wget -q https://raw.githubusercontent.com/adrianmalec/my-elementary-os/master/terminator-config -O ~/.config/terminator/config
wget -q https://raw.githubusercontent.com/adrianmalec/my-elementary-os/master/universal-zshrc -O ~/.zshrc
wget -q https://raw.githubusercontent.com/adrianmalec/my-elementary-os/master/powerlevel9k-config -O ~/.zshrc_powerlevel9k
wget -q https://raw.githubusercontent.com/adrianmalec/my-elementary-os/master/zshrc-aliases -O ~/.zshrc_aliases

# install nerd fonts

mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts && curl -fLo "Droid Sans Mono for Powerline Nerd Font Complete.otf" https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/DroidSansMono/complete/Droid%20Sans%20Mono%20Nerd%20Font%20Complete.otf > /dev/null
fc-cache -f -v > /dev/null
cd ~/

# vim
sh -c "$(curl -fsSL https://j.mp/spf13-vim3)"

cat <<EOF > ~/.vimrc.local
set nospell
set nolist
let g:go_fmt_command = "goimports"
let g:NERDTreeWinPos = "left"
autocmd vimenter * if !argc() | NERDTree | endif
if has("gui_running")
  " GUI is running or is about to start.
  " Maximize gvim window.
  set lines=999 columns=999
endif
EOF

printf "\n%s [DONE]\n" "... initialized"
