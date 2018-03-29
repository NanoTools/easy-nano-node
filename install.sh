#!/bin/bash

echo "== Cloning installation"
git clone https://github.com/nanotools/easy-nano-node.git /opt/easy-nano-node

echo "== Starting installation"
bash /opt/easy-nano-node/enn/setup.sh