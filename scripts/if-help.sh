#!/bin/bash
# print help shell if statement
set -e

cat << EOF
shell if help

number
  a -eq b:	a equal b                    [ a == b ]
  a -ne b:	a not equal b                [ a != b ]
  a -gt b:	a greater than b             [ a >  b ]
  a -ge b:	a greater than or equal to b [ a >= b ]
  a -lt b:	a less than b                [ a <  b ]
  a -le b:	a less than or equal to b    [ a <= b ]
string
  a = b  :	a equal b                    [ a == b ]
  a != b :	a not equal b                [ a != b ]
  -n a   :	a length >= 1                [ a != "" ]
  -z a   :	a length ==  0               [ a == "" ]
EOF
