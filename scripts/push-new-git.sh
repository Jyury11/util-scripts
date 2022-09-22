#!/bin/bash
# push init git repository
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

git init
git remote add origin git@$host:${userId}/${repository}.git
if [[ -f "README.md" ]]; then
  echo "README.md is exists."
else
  echo "README.md is not exists. create README.md."
  echo "# $(basename $(pwd))" > README.md
fi
git add .

read -p "git first commit message? (default: create): " message
if [[ -z "$message" ]]; then
  message="create"
fi
git commit -m "feat: $message"
git branch -M main
git push -u origin main
