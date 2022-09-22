#!/bin/bash
# set git global config
set -e

read -p "git user email?: " email
if [[ -z "$email" ]]; then
  echo "email is blank." >2
  exit
fi

read -p "git user name?: " username
if [[ -z "$username" ]]; then
  echo "user name is blank." >2
  exit
fi

git config --global user.email $email
git config --global user.name $username

git config --global core.editor vim
git config --global core.autocrlf input
git config --global core.filemode false
git config --global core.ignorecase false
git config --global core.quotepath false

git config --global color.ui true
git config --global color.diff auto
git config --global color.status auto
git config --global color.branch auto

git config --global push.default current
git config --global merge.ff false
git config --global pull.ff only
git config --global init.defaultBranch main

git config --global alias.push-f "push --force-with-lease"
