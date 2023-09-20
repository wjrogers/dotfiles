#!/bin/bash

# create standard directories
mkdir -p ~/.config
mkdir -p ~/.local/bin

# ensure permissions
chmod 755 ~/.config
chmod 755 ~/.local ~/.local/*

# pre-requisites
sudo add-apt-repository -y --no-update ppa:git-core/ppa
sudo apt update
sudo apt install -y build-essential curl file git stow

# configuration (explicit target in case ~/.dotfiles is a symlink)
STOW_CMD="stow -v --target $HOME"
$STOW_CMD home
