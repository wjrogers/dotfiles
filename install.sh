#!/bin/bash

set -euxo pipefail

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# create standard directories
mkdir -p ~/.config
mkdir -p ~/.local/bin
mkdir -p ~/.local/share/bash-completion/completions

# ensure permissions
chmod 755 ~/.config
chmod 755 ~/.local ~/.local/*

# pre-requisites
sudo apt update
sudo apt install -y curl gnupg python3-pip python3-venv software-properties-common

# bootstrap pip from GitHub
PIPX=$(readlink -f ~/.local/bin/pipx)
curl -fSL# -o "$PIPX" https://github.com/pypa/pipx/releases/download/1.6.0/pipx.pyz && chmod +x "$PIPX"

# install ansible
"$PIPX" install --include-deps 'ansible>=9,<10'
"$PIPX" inject --include-apps ansible 'ansible-lint>=24,<25'

# run
ANSIBLE_CONFIG="${SCRIPT_DIR}/ansible.cfg" ansible-playbook -i "${SCRIPT_DIR}/inventory.yaml" "${SCRIPT_DIR}/playbook.yaml"
