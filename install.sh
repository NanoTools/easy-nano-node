#!/bin/bash

# we need git to clone the repo
test -f "$(which git )" || { echo "Git is not installed"; exit 1; }

echo "== Cloning installation"
# if the directory already exists pull the repo
# otherwise clone it
git -C /opt/easy-nano-node pull || git clone https://github.com/nanotools/easy-nano-node.git /opt/easy-nano-node

echo "== Starting installation"
# and fire!
sudo bash /opt/easy-nano-node/enn/setup.sh