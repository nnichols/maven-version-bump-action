#!/bin/bash

# Directory of this script
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

git config --global user.email $EMAIL
git config --global user.name $NAME

BUMP_MODE="none"
if git log -1 | grep -q "#major"; then
  BUMP_MODE="major"
elif git log -1 | grep -q "#minor"; then
  BUMP_MODE="minor"
elif git log -1 | grep -q "#patch"; then
  BUMP_MODE="patch"
fi
echo "$BUMP_MODE"
