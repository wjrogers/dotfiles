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

# homebrew
if ! command -v brew > /dev/null; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh)"
  test -d ~/.linuxbrew && eval $(~/.linuxbrew/bin/brew shellenv)
  test -d /home/linuxbrew/.linuxbrew && eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
fi

# homebrew packages
brew bundle

# configuration (explicit target in case ~/.dotfiles is a symlink)
STOW_CMD="stow -v --target $HOME"
$STOW_CMD home
