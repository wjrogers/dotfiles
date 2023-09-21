#!/bin/bash

set -euxo pipefail

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# create standard directories
mkdir -p ~/.config
mkdir -p ~/.local/bin

# ensure permissions
chmod 755 ~/.config
chmod 755 ~/.local ~/.local/*

# pre-requisites
sudo apt update
sudo apt install -y curl gnupg python3-venv pipx software-properties-common

# install ansible
python3 -m pipx ensurepath
pipx install --include-deps ansible
pipx inject --include-apps ansible ansible-lint

# run
ANSIBLE_CONFIG="${SCRIPT_DIR}/ansible.cfg" ansible-playbook -i "${SCRIPT_DIR}/inventory.yaml" "${SCRIPT_DIR}/playbooks/system.yaml"
ANSIBLE_CONFIG="${SCRIPT_DIR}/ansible.cfg" ansible-playbook -i "${SCRIPT_DIR}/inventory.yaml" "${SCRIPT_DIR}/playbooks/user.yaml"
