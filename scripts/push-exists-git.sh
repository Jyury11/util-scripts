#!/bin/bash
# push exists git repository
set -e

read -p "git host? (default: github.com): " host
if [[ -z "$host" ]]; then
  host="github.com"
fi

read -p "git user id? (default: use git config user.name): " userId
if [[ -z "$userId" ]]; then
  userId="$(git config user.name)"
fi
if [[ -z "$userId" ]]; then
  echo "git user id is blank." >2
  exit
fi

read -p "git repository?: " repository
if [[ -z "$repository" ]]; then
  echo "git repository is blank." >2
  exit
fi

git remote origin old-origin
git remote add origin git@$host:${userId}/${repository}.git
git branch -M main
git push -u origin main
