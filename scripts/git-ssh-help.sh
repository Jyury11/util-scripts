#!/bin/bash
# print help git with ssh
set -e

cat << 'EOF'
help git with ssh

check url
  git config remote.origin.url

set url
  git remote set-url origin git@github.com:${userId}/${repository}.git
EOF
