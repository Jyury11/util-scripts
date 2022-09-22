#!/bin/bash
# print help ln statement
set -e

cat << EOF
ln help

create symbolic link
  ln -s filename linkname
delete symbolic link
  unlink linkname
EOF
