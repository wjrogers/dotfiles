#!/bin/bash

set -euxo pipefail

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# create standard directories
mkdir -p ~/.cache
mkdir -p ~/.config
mkdir -p ~/.local/bin
mkdir -p ~/.local/share/bash-completion/completions

# ensure permissions
chmod 755 ~/.config
chmod 755 ~/.local ~/.local/*

# ensure ~/.local/bin is in PATH
if [[ ! ":$PATH:" == *":$HOME/.local/bin:"* ]]; then
    export PATH="$HOME/.local/bin:$PATH"
fi

# pre-requisites
sudo apt update
sudo apt install -y curl gnupg python3-pip python3-venv software-properties-common

# bootstrap uv from GitHub
"${SCRIPT_DIR}/install-uv.sh"

# install python tools
UV=$(readlink -f ~/.local/bin/uv)
"$UV" tool install --with-executables-from ansible-core,ansible-lint --with python-debian 'ansible>=11,<12'
"$UV" tool install -U 'ruff'

# run
ANSIBLE_CONFIG="${SCRIPT_DIR}/ansible.cfg" ansible-playbook -i "${SCRIPT_DIR}/inventory.yaml" "${SCRIPT_DIR}/playbook.yaml"
