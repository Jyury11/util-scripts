#!/bin/bash
# create ssh key and copy public key to clipboard
set -e

mkdir -p ~/.ssh && cd ~/.ssh && ssh-keygen -t ed25519
echo "set public key to your clipboard"
pbcopy < ~/.ssh/id_ed25519_gitlab.pub
